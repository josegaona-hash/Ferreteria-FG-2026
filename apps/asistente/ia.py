"""Asistente de ventas con IA (Claude) conectado al inventario real."""
import json

import anthropic
from decouple import config
from django.db.models import Q

from apps.inventario.models import Categoria, Producto

MODELO = 'claude-opus-5-5'
MAX_VUELTAS = 6          # máximo de rondas de herramientas por pregunta
MAX_MENSAJES = 20        # historial que se envía a la IA
MAX_LARGO_MENSAJE = 2000

SYSTEM_PROMPT = """Eres el asistente de ventas de Ferretería FG, una ferretería en Paraguay.
Ayudas al vendedor del mostrador (o al cliente) a encontrar los productos adecuados para su trabajo.

Cómo trabajar:
- Cuando te describan un problema o trabajo (ej. "tengo una fuga en el lavamanos"), piensa qué materiales y herramientas se necesitan y búscalos en el inventario con la herramienta buscar_productos. Busca con varios términos sencillos (ej. "sifón", "teflón", "llave inglesa").
- Recomienda SOLO productos que existan en el inventario, con su precio en guaraníes (Gs.) y si hay stock. Nunca inventes productos, precios ni stock.
- Si algo necesario no está en el inventario o no tiene stock, dilo claramente y sugiere una alternativa del inventario si la hay.
- Da consejos prácticos breves de uso o instalación cuando ayuden a la venta.
- Responde en español, de forma breve y clara. Usa listas cortas. Escribe los nombres de los productos exactamente como aparecen en el inventario.
- Si la pregunta no tiene relación con la ferretería, responde amablemente que solo puedes ayudar con productos y trabajos de ferretería."""

HERRAMIENTAS = [
    {
        'name': 'buscar_productos',
        'description': (
            'Busca productos activos del inventario de la ferretería por palabras clave. '
            'Compara cada término con el nombre, la descripción, la categoría y los códigos del producto. '
            'Devuelve id, nombre, precio de venta (Gs.), stock disponible, unidad y categoría. '
            'Usa varios términos cortos y sencillos para encontrar más resultados.'
        ),
        'input_schema': {
            'type': 'object',
            'properties': {
                'terminos': {
                    'type': 'array',
                    'items': {'type': 'string'},
                    'description': 'Palabras clave a buscar, ej. ["tornillo", "taladro", "pintura"].',
                },
            },
            'required': ['terminos'],
            'additionalProperties': False,
        },
        'strict': True,
    },
    {
        'name': 'listar_categorias',
        'description': 'Lista las categorías de productos activas del inventario, para saber qué tipo de productos vende la ferretería.',
        'input_schema': {'type': 'object', 'properties': {}, 'additionalProperties': False},
        'strict': True,
    },
]


class AsistenteError(Exception):
    """Error que se puede mostrar al usuario."""


def _producto_dict(p):
    return {
        'id': p.id,
        'nombre': p.nombre,
        'precio': int(p.precio_venta),
        'stock': p.stock,
        'unidad': p.unidad_medida.abreviatura if p.unidad_medida else '',
        'categoria': p.categoria.nombre if p.categoria else '',
    }


def buscar_productos(terminos):
    filtro = Q()
    for t in [t.strip() for t in terminos if t and t.strip()][:10]:
        filtro |= (Q(nombre__icontains=t) | Q(descripcion__icontains=t) |
                   Q(categoria__nombre__icontains=t) | Q(codigo_barras__icontains=t) |
                   Q(codigo_interno__icontains=t))
    if not filtro:
        return []
    productos = (Producto.objects.filter(activo=True).filter(filtro)
                 .select_related('categoria', 'unidad_medida').order_by('-stock', 'nombre')[:25])
    return [_producto_dict(p) for p in productos]


def listar_categorias():
    return list(Categoria.objects.filter(activo=True).values_list('nombre', flat=True))


def _ejecutar_herramienta(nombre, entrada, encontrados):
    if nombre == 'buscar_productos':
        terminos = entrada.get('terminos')
        if not isinstance(terminos, list):
            raise ValueError('terminos debe ser una lista')
        resultado = buscar_productos([str(t) for t in terminos])
        for p in resultado:
            encontrados[p['id']] = p
        return resultado or 'No se encontraron productos con esos términos.'
    if nombre == 'listar_categorias':
        return listar_categorias()
    raise ValueError(f'Herramienta desconocida: {nombre}')


def _limpiar_historial(historial):
    """Acepta solo mensajes de texto user/assistant, recortados, empezando por user."""
    mensajes = []
    for m in historial[-MAX_MENSAJES:]:
        rol, texto = m.get('role'), m.get('content')
        if rol in ('user', 'assistant') and isinstance(texto, str) and texto.strip():
            mensajes.append({'role': rol, 'content': texto.strip()[:MAX_LARGO_MENSAJE]})
    while mensajes and mensajes[0]['role'] != 'user':
        mensajes.pop(0)
    if not mensajes or mensajes[-1]['role'] != 'user':
        raise AsistenteError('Escribe una pregunta para el asistente.')
    return mensajes


def responder(historial):
    """Devuelve {'respuesta': str, 'productos': [...]} para el último mensaje del historial."""
    api_key = config('ANTHROPIC_API_KEY', default='')
    if not api_key:
        raise AsistenteError('Falta configurar ANTHROPIC_API_KEY en el archivo .env.')

    client = anthropic.Anthropic(api_key=api_key)
    mensajes = _limpiar_historial(historial)
    encontrados = {}

    for _ in range(MAX_VUELTAS):
        try:
            response = client.beta.messages.create(
                model=MODELO,
                max_tokens=16000,
                system=[{'type': 'text', 'text': SYSTEM_PROMPT, 'cache_control': {'type': 'ephemeral'}}],
                tools=HERRAMIENTAS,
                messages=mensajes,
                output_config={'effort': 'low'},
                betas=['server-side-fallback-2026-07-01'],
                fallbacks='default',
            )
        except anthropic.AuthenticationError:
            raise AsistenteError('La clave ANTHROPIC_API_KEY no es válida.')
        except anthropic.RateLimitError:
            raise AsistenteError('Demasiadas consultas seguidas. Intenta de nuevo en un momento.')
        except anthropic.APIConnectionError:
            raise AsistenteError('No hay conexión con el servicio de IA. Revisa la conexión a internet.')
        except anthropic.APIStatusError as e:
            raise AsistenteError(f'El servicio de IA respondió con un error ({e.status_code}).')

        if response.stop_reason == 'refusal':
            raise AsistenteError('El asistente no puede responder esa consulta.')

        if response.stop_reason != 'tool_use':
            texto = '\n'.join(b.text for b in response.content if b.type == 'text').strip()
            if not texto:
                raise AsistenteError('El asistente no generó una respuesta. Intenta reformular la pregunta.')
            texto_min = texto.lower()
            productos = [p for p in encontrados.values() if p['nombre'].lower() in texto_min]
            return {'respuesta': texto, 'productos': productos}

        # Ejecutar las herramientas pedidas y devolver todos los resultados en un solo mensaje
        mensajes.append({'role': 'assistant', 'content': response.content})
        resultados = []
        for bloque in response.content:
            if bloque.type != 'tool_use':
                continue
            try:
                salida = _ejecutar_herramienta(bloque.name, bloque.input or {}, encontrados)
                resultados.append({'type': 'tool_result', 'tool_use_id': bloque.id,
                                   'content': json.dumps(salida, ensure_ascii=False)})
            except Exception as e:
                resultados.append({'type': 'tool_result', 'tool_use_id': bloque.id,
                                   'content': f'Error: {e}', 'is_error': True})
        mensajes.append({'role': 'user', 'content': resultados})

    raise AsistenteError('La consulta tomó demasiados pasos. Intenta con una pregunta más concreta.')
