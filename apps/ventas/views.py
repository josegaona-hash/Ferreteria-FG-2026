from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
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


class DashboardView(LoginRequiredMixin, TemplateView):
    template_name = 'ventas/dashboard.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        hoy = timezone.now().date()
        ventas_hoy = Venta.objects.filter(fecha__date=hoy, estado='pagada')
        ctx['ventas_hoy'] = ventas_hoy.count()
        ctx['ingresos_hoy'] = ventas_hoy.aggregate(t=Sum('total'))['t'] or 0
        ctx['total_productos'] = Producto.objects.filter(activo=True).count()
        ctx['stock_bajo'] = Producto.objects.filter(activo=True, stock__lte=5).count()
        ctx['total_clientes'] = Cliente.objects.filter(activo=True).count()
        ctx['ultimas_ventas'] = Venta.objects.select_related('cliente').order_by('-fecha')[:8]
        ctx['productos_stock_bajo'] = Producto.objects.filter(activo=True, stock__lte=5).select_related('categoria')[:8]
        return ctx


class PosView(LoginRequiredMixin, TemplateView):
    template_name = 'ventas/pos.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['clientes'] = Cliente.objects.filter(activo=True).values('id', 'nombre')
        return ctx


class VentaListView(LoginRequiredMixin, ListView):
    model = Venta
    template_name = 'ventas/venta_list.html'
    context_object_name = 'ventas'
    paginate_by = 25

    def get_queryset(self):
        qs = Venta.objects.select_related('cliente', 'usuario').order_by('-fecha')
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


class VentaDetailView(LoginRequiredMixin, DetailView):
    model = Venta
    template_name = 'ventas/venta_detail.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['detalles'] = self.object.detalles.select_related('producto')
        return ctx


@login_required
def buscar_producto(request):
    q = request.GET.get('q', '').strip()
    if not q:
        return JsonResponse({'productos': []})
    productos = Producto.objects.filter(
        activo=True, stock__gt=0
    ).filter(Q(nombre__icontains=q) | Q(codigo_barras__icontains=q))[:10]
    data = [{'id': p.id, 'nombre': p.nombre, 'codigo': p.codigo_barras,
              'precio': float(p.precio_venta), 'stock': p.stock} for p in productos]
    return JsonResponse({'productos': data})


@login_required
@transaction.atomic
def crear_venta(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'Método no permitido'}, status=405)
    try:
        data = json.loads(request.body)
        items = data.get('items', [])
        if not items:
            return JsonResponse({'error': 'Sin productos'}, status=400)

        cliente_id = data.get('cliente_id')
        forma_pago = data.get('forma_pago', 'contado')

        venta = Venta(
            cliente_id=cliente_id or None,
            forma_pago=forma_pago,
            usuario=request.user,
        )

        total = 0
        detalles = []
        for item in items:
            prod = Producto.objects.select_for_update().get(id=item['producto_id'], activo=True)
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
            tipo='ingreso',
            descripcion=f'Venta {venta.numero} – {forma_pago}',
            monto=total,
            venta=venta,
            usuario=request.user,
        )

        return JsonResponse({'ok': True, 'venta_id': venta.id, 'numero': venta.numero, 'total': total})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
