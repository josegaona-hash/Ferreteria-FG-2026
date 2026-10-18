from django.views.generic import ListView, DetailView, TemplateView
from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse, HttpResponse
from django.db import transaction
from django.db.models import Sum, Count, Q
from django.utils import timezone
from django.contrib import messages
import json
from .models import Venta, DetalleVenta
from apps.inventario.models import Producto
from apps.clientes.models import Cliente
from apps.caja.models import MovimientoCaja
from apps.empresas.mixins import EmpresaMixin, empresa_requerida
from apps.empresas.models import Empresa


class DashboardView(EmpresaMixin, TemplateView):
    template_name = 'ventas/dashboard.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        hoy = timezone.now().date()
        ventas = Venta.objects.filter(empresa=self.request.empresa)
        productos = Producto.objects.filter(empresa=self.request.empresa, activo=True)
        ventas_hoy = ventas.filter(fecha__date=hoy, estado='pagada')
        ctx['ventas_hoy'] = ventas_hoy.count()
        ctx['ingresos_hoy'] = ventas_hoy.aggregate(t=Sum('total'))['t'] or 0
        ctx['total_productos'] = productos.count()
        ctx['stock_bajo'] = productos.filter(stock__lte=5).count()
        ctx['total_clientes'] = Cliente.objects.filter(empresa=self.request.empresa, activo=True).count()
        ctx['ultimas_ventas'] = ventas.select_related('cliente').order_by('-fecha')[:8]
        ctx['productos_stock_bajo'] = productos.filter(stock__lte=5).select_related('categoria')[:8]
        return ctx


class PosView(EmpresaMixin, TemplateView):
    template_name = 'ventas/pos.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['clientes'] = Cliente.objects.filter(empresa=self.request.empresa, activo=True).values('id', 'nombre')
        return ctx


class VentaListView(EmpresaMixin, ListView):
    model = Venta
    template_name = 'ventas/venta_list.html'
    context_object_name = 'ventas'
    paginate_by = 25

    def get_queryset(self):
        qs = super().get_queryset().select_related('cliente', 'usuario').order_by('-fecha')
        q = self.request.GET.get('q')
        estado = self.request.GET.get('estado')
        pago = self.request.GET.get('pago')
        if q:
            qs = qs.filter(Q(numero__icontains=q) | Q(cliente__nombre__icontains=q))
        if estado:
            qs = qs.filter(estado=estado)
        if pago:
            qs = qs.filter(forma_pago=pago)
        return qs


class VentaDetailView(EmpresaMixin, DetailView):
    model = Venta
    template_name = 'ventas/venta_detail.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['detalles'] = self.object.detalles.select_related('producto')
        return ctx


@empresa_requerida
def buscar_producto(request):
    q = request.GET.get('q', '').strip()
    if not q:
        return JsonResponse({'productos': []})
    productos = Producto.objects.filter(
        empresa=request.empresa, activo=True, stock__gt=0
    ).filter(Q(nombre__icontains=q) | Q(codigo_barras__icontains=q))[:10]
    data = [{'id': p.id, 'nombre': p.nombre, 'codigo': p.codigo_barras,
              'precio': float(p.precio_venta), 'stock': p.stock} for p in productos]
    return JsonResponse({'productos': data})


@empresa_requerida
@transaction.atomic
def crear_venta(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    try:
        data = json.loads(request.body)
        items = data.get('items', [])
        if not items:
            return JsonResponse({'error': 'Sin productos'}, status=400)

        cliente_id = data.get('cliente_id') or None
        forma_pago = data.get('forma_pago', 'contado')
        if cliente_id and not Cliente.objects.filter(id=cliente_id, empresa=request.empresa).exists():
            return JsonResponse({'error': 'Cliente no encontrado'}, status=400)

        # Bloquea la empresa para que dos ventas simultáneas no reciban el mismo número
        Empresa.objects.select_for_update().get(pk=request.empresa.pk)

        venta = Venta(
            empresa=request.empresa,
            cliente_id=cliente_id,
            forma_pago=forma_pago,
            usuario=request.user,
        )

        total = 0
        detalles = []
        for item in items:
            prod = Producto.objects.select_for_update().get(id=item['producto_id'], empresa=request.empresa, activo=True)
            if prod.stock < item['cantidad']:
                return JsonResponse({'error': f'Stock insuficiente: {prod.nombre}'}, status=400)
            subtotal = int(prod.precio_venta) * item['cantidad']
            total += subtotal
            detalles.append({'producto': prod, 'cantidad': item['cantidad'],
                              'precio_unitario': prod.precio_venta, 'subtotal': subtotal})

        venta.subtotal = total
        venta.iva = total // 11
        venta.total = total
        venta.save()

        for d in detalles:
            DetalleVenta.objects.create(venta=venta, **d)
            d['producto'].stock -= d['cantidad']
            d['producto'].save()

        MovimientoCaja.objects.create(
            empresa=request.empresa,
            tipo='ingreso',
            descripcion=f'Venta {venta.numero} – {forma_pago}',
            monto=total,
            venta=venta,
            usuario=request.user,
        )

        return JsonResponse({'ok': True, 'venta_id': venta.id, 'numero': venta.numero, 'total': total})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
