from django.views.generic import ListView, TemplateView
from django.shortcuts import redirect
from django.contrib import messages
from django.db.models import Sum
from django.utils import timezone
from apps.empresas.mixins import EmpresaMixin, empresa_requerida
from .models import MovimientoCaja


class CajaView(EmpresaMixin, TemplateView):
    template_name = 'caja/caja.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        movs = MovimientoCaja.objects.filter(empresa=self.request.empresa)
        ctx['total_ingresos'] = movs.filter(tipo='ingreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['total_egresos'] = movs.filter(tipo='egreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['saldo'] = ctx['total_ingresos'] - ctx['total_egresos']
        ctx['movimientos'] = movs.order_by('-fecha')[:50]
        return ctx


@empresa_requerida
def registrar_movimiento(request):
    if request.method == 'POST':
        tipo = request.POST.get('tipo')
        monto = request.POST.get('monto')
        descripcion = request.POST.get('descripcion', '')
        if tipo in dict(MovimientoCaja.TIPO_CHOICES) and monto:
            MovimientoCaja.objects.create(
                empresa=request.empresa,
                tipo=tipo, monto=monto,
                descripcion=descripcion or 'Movimiento manual',
                usuario=request.user,
            )
            messages.success(request, 'Movimiento registrado correctamente.')
    return redirect('caja:caja')
