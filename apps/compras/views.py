from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, CreateView, DetailView, UpdateView
from django.urls import reverse_lazy
from django.contrib import messages
from .models import Compra

class CompraListView(LoginRequiredMixin, ListView):
    model = Compra
    template_name = 'compras/compra_list.html'
    context_object_name = 'compras'
    paginate_by = 20

class CompraDetailView(LoginRequiredMixin, DetailView):
    model = Compra
    template_name = 'compras/compra_detail.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['detalles'] = self.object.detalles.select_related('producto')
        return ctx
