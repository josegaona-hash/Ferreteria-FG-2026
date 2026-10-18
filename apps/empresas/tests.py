import json
from io import StringIO

from django.contrib.auth.models import User
from django.core.management import call_command
from django.test import TestCase
from django.urls import reverse

from apps.caja.models import MovimientoCaja
from apps.clientes.models import Cliente
from apps.inventario.models import Producto, UnidadMedida
from apps.usuarios.models import Perfil
from apps.ventas.models import Venta
from .models import Empresa


def crear_usuario(username, empresa, **kwargs):
    user = User.objects.create_user(username=username, password='clave-segura-123', **kwargs)
    Perfil.objects.create(user=user, empresa=empresa)
    return user


class AislamientoEntreEmpresasTests(TestCase):
    def setUp(self):
        self.empresa_a = Empresa.objects.create(nombre='Ferretería A')
        self.empresa_b = Empresa.objects.create(nombre='Ferretería B')
        self.user_a = crear_usuario('ana', self.empresa_a)
        self.user_b = crear_usuario('beto', self.empresa_b)
        self.prod_a = Producto.objects.create(empresa=self.empresa_a, nombre='Martillo A', precio_venta=50000, stock=10)
        self.prod_b = Producto.objects.create(empresa=self.empresa_b, nombre='Taladro B', precio_venta=300000, stock=10)
        self.cliente_b = Cliente.objects.create(empresa=self.empresa_b, nombre='Cliente de B')
        self.client.force_login(self.user_a)

    def vender(self, producto, **extra):
        data = {'items': [{'producto_id': producto.id, 'cantidad': 1}], **extra}
        return self.client.post(reverse('ventas:crear_venta'), json.dumps(data), content_type='application/json')

    def test_listado_de_productos_solo_muestra_los_propios(self):
        resp = self.client.get(reverse('inventario:producto_list'))
        self.assertContains(resp, 'Martillo A')
        self.assertNotContains(resp, 'Taladro B')

    def test_no_puede_abrir_productos_de_otra_empresa(self):
        for nombre in ['inventario:producto_detail', 'inventario:producto_update']:
            resp = self.client.get(reverse(nombre, args=[self.prod_b.id]))
            self.assertEqual(resp.status_code, 404, nombre)

    def test_buscador_del_pos_solo_devuelve_productos_propios(self):
        resp = self.client.get(reverse('ventas:buscar_producto'), {'q': 'a'})
        nombres = [p['nombre'] for p in resp.json()['productos']]
        self.assertEqual(nombres, ['Martillo A'])

    def test_no_puede_vender_productos_ni_clientes_de_otra_empresa(self):
        self.assertNotEqual(self.vender(self.prod_b).status_code, 200)
        self.assertEqual(self.vender(self.prod_a, cliente_id=self.cliente_b.id).status_code, 400)
        self.prod_b.refresh_from_db()
        self.assertEqual(self.prod_b.stock, 10)
        self.assertFalse(Venta.objects.exists())

    def test_venta_queda_en_la_empresa_del_usuario(self):
        resp = self.vender(self.prod_a)
        self.assertEqual(resp.status_code, 200)
        venta = Venta.objects.get()
        self.assertEqual(venta.empresa, self.empresa_a)
        self.assertEqual(MovimientoCaja.objects.get().empresa, self.empresa_a)

    def test_numeracion_de_ventas_independiente_por_empresa(self):
        self.vender(self.prod_a)
        self.vender(self.prod_a)
        self.client.force_login(self.user_b)
        self.vender(self.prod_b)
        numeros = {(v.empresa.nombre, v.numero) for v in Venta.objects.all()}
        self.assertEqual(numeros, {
            ('Ferretería A', 'V000001'), ('Ferretería A', 'V000002'), ('Ferretería B', 'V000001'),
        })

    def test_producto_nuevo_se_crea_en_la_empresa_del_usuario(self):
        unidad_b = UnidadMedida.objects.create(empresa=self.empresa_b, nombre='Metro', abreviatura='m')
        datos = {'nombre': 'Clavos', 'precio_costo': 100, 'precio_venta': 200, 'precio_mayorista': 150,
                 'stock': 5, 'stock_minimo': 1, 'codigo_interno': 'CL-1'}
        # No puede elegir una unidad de medida de otra empresa
        resp = self.client.post(reverse('inventario:producto_create'), {**datos, 'unidad_medida': unidad_b.id})
        self.assertEqual(resp.status_code, 200)
        self.assertIn('unidad_medida', resp.context['form'].errors)

        resp = self.client.post(reverse('inventario:producto_create'), datos)
        self.assertEqual(resp.status_code, 302)
        self.assertEqual(Producto.objects.get(nombre='Clavos').empresa, self.empresa_a)

    def test_codigo_interno_repetido_solo_dentro_de_la_misma_empresa(self):
        Producto.objects.filter(pk=self.prod_b.pk).update(codigo_interno='X1')
        datos = {'nombre': 'Pinza', 'precio_costo': 0, 'precio_venta': 100, 'precio_mayorista': 0,
                 'stock': 1, 'stock_minimo': 1, 'codigo_interno': 'X1'}
        resp = self.client.post(reverse('inventario:producto_create'), datos)
        self.assertEqual(resp.status_code, 302)

        resp = self.client.post(reverse('inventario:producto_create'), {**datos, 'nombre': 'Otra pinza'})
        self.assertEqual(resp.status_code, 200)
        self.assertContains(resp, 'Ya existe un producto con este código interno.')

    def test_usuario_sin_empresa_o_suspendida_no_tiene_acceso(self):
        sin_empresa = User.objects.create_user(username='nadie', password='x')
        self.client.force_login(sin_empresa)
        self.assertEqual(self.client.get(reverse('ventas:dashboard')).status_code, 403)

        self.empresa_a.activa = False
        self.empresa_a.save()
        self.client.force_login(self.user_a)
        self.assertEqual(self.client.get(reverse('ventas:dashboard')).status_code, 403)
        self.assertEqual(self.client.get(reverse('ventas:buscar_producto'), {'q': 'a'}).status_code, 403)

    def test_dashboard_cuenta_solo_datos_propios(self):
        resp = self.client.get(reverse('ventas:dashboard'))
        self.assertEqual(resp.context['total_productos'], 1)
        self.assertContains(resp, 'Ferretería A')


class AdminPorEmpresaTests(TestCase):
    def setUp(self):
        call_command('crear_empresa', 'Ferretería A', usuario='ana', password='clave-segura-123', stdout=StringIO())
        call_command('crear_empresa', 'Ferretería B', usuario='beto', password='clave-segura-123', stdout=StringIO())
        self.empresa_a = Empresa.objects.get(nombre='Ferretería A')
        self.empresa_b = Empresa.objects.get(nombre='Ferretería B')
        Producto.objects.create(empresa=self.empresa_a, nombre='Martillo A', precio_venta=1)
        Producto.objects.create(empresa=self.empresa_b, nombre='Taladro B', precio_venta=1)

    def test_crear_empresa_prepara_usuario_y_unidades(self):
        ana = User.objects.get(username='ana')
        self.assertTrue(ana.is_staff)
        self.assertFalse(ana.is_superuser)
        self.assertEqual(ana.perfil.empresa, self.empresa_a)
        self.assertEqual(UnidadMedida.objects.filter(empresa=self.empresa_a).count(), 6)

    def test_admin_de_empresa_solo_ve_sus_datos(self):
        self.client.login(username='ana', password='clave-segura-123')
        resp = self.client.get('/admin/inventario/producto/')
        self.assertContains(resp, 'Martillo A')
        self.assertNotContains(resp, 'Taladro B')
        self.assertEqual(self.client.get('/admin/auth/user/').status_code, 403)
        self.assertEqual(self.client.get('/admin/empresas/empresa/').status_code, 403)

    def test_admin_de_empresa_crea_registros_en_su_empresa(self):
        self.client.login(username='ana', password='clave-segura-123')
        resp = self.client.post('/admin/clientes/cliente/add/', {'nombre': 'Nuevo', 'limite_credito': 0, 'activo': 'on'})
        self.assertEqual(resp.status_code, 302)
        self.assertEqual(Cliente.objects.get(nombre='Nuevo').empresa, self.empresa_a)

    def test_superusuario_ve_todas_las_empresas(self):
        User.objects.create_superuser('dueno', password='clave-segura-123')
        self.client.login(username='dueno', password='clave-segura-123')
        resp = self.client.get('/admin/inventario/producto/')
        self.assertContains(resp, 'Martillo A')
        self.assertContains(resp, 'Taladro B')


class RespaldoTests(TestCase):
    def test_respaldo_genera_archivo_y_conserva_los_ultimos(self):
        import tempfile
        from pathlib import Path
        Empresa.objects.create(nombre='Ferretería A')
        with tempfile.TemporaryDirectory() as carpeta:
            for i in range(3):
                (Path(carpeta) / f'respaldo-2000010{i}-000000.json.gz').write_bytes(b'')
            call_command('respaldar', salida=carpeta, conservar=2, stdout=StringIO())
            archivos = sorted(p.name for p in Path(carpeta).iterdir())
            self.assertEqual(len(archivos), 2)
            self.assertNotIn('respaldo-20000100-000000.json.gz', archivos)
