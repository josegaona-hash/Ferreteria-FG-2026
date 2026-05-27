from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth.decorators import login_required
from django.views.generic import ListView, TemplateView
from django.shortcuts import redirect
from django.contrib import messages
from django.db.models import Sum
from django.utils import timezone
from .models import MovimientoCaja


class CajaView(LoginRequiredMixin, TemplateView):
    template_name = 'caja/caja.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        movs = MovimientoCaja.objects.all()
        ctx['total_ingresos'] = movs.filter(tipo='ingreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['total_egresos'] = movs.filter(tipo='egreso').aggregate(t=Sum('monto'))['t'] or 0
        ctx['saldo'] = ctx['total_ingresos'] - ctx['total_egresos']
        ctx['movimientos'] = movs.order_by('-fecha')[:50]
        return ctx


@login_required
def registrar_movimiento(request):
    if request.method == 'POST':
        tipo = request.POST.get('tipo')
        monto = request.POST.get('monto')
        descripcion = request.POST.get('descripcion', '')
        if tipo and monto:
            MovimientoCaja.objects.create(
                tipo=tipo, monto=monto,
                descripcion=descripcion or 'Movimiento manual',
                usuario=request.user,
            )
            messages.success(request, 'Movimiento registrado correctamente.')
    return redirect('caja:caja')
