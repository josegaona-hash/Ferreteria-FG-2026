from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView
from django.db.models import Sum, Count
from django.utils import timezone
from apps.ventas.models import Venta
from apps.inventario.models import Producto
from apps.caja.models import MovimientoCaja


class ReporteVentasView(LoginRequiredMixin, TemplateView):
    template_name = 'reportes/reporte_ventas.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        hoy = timezone.now().date()
        inicio_mes = hoy.replace(day=1)
        ctx['ventas_mes'] = Venta.objects.filter(fecha__date__gte=inicio_mes, estado='pagada')
        ctx['total_mes'] = ctx['ventas_mes'].aggregate(t=Sum('total'))['t'] or 0
        ctx['cantidad_mes'] = ctx['ventas_mes'].count()
        return ctx


class ReporteInventarioView(LoginRequiredMixin, TemplateView):
    template_name = 'reportes/reporte_inventario.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['productos'] = Producto.objects.filter(activo=True).select_related('categoria').order_by('nombre')
        return ctx


class ReporteCajaView(LoginRequiredMixin, TemplateView):
    template_name = 'reportes/reporte_caja.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        movs = MovimientoCaja.objects.all()
        ctx['ingresos'] = movs.filter(tipo='ingreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['egresos'] = movs.filter(tipo='egreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['movimientos'] = movs.order_by('-fecha')[:100]
        return ctx
