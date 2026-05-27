from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, CreateView, UpdateView, DetailView
from django.urls import reverse_lazy
from django.contrib import messages
from .models import Proveedor


class ProveedorListView(LoginRequiredMixin, ListView):
    model = Proveedor
    template_name = 'proveedores/proveedor_list.html'
    context_object_name = 'proveedores'
    paginate_by = 20

    def get_queryset(self):
        qs = Proveedor.objects.filter(activo=True)
        q = self.request.GET.get('q')
        if q:
            from django.db.models import Q
            qs = qs.filter(Q(nombre__icontains=q) | Q(ruc__icontains=q))
        return qs


class ProveedorCreateView(LoginRequiredMixin, CreateView):
    model = Proveedor
    template_name = 'proveedores/proveedor_form.html'
    fields = ['nombre', 'ruc', 'contacto', 'telefono', 'email', 'direccion', 'ciudad', 'notas']
    success_url = reverse_lazy('proveedores:proveedor_list')

    def form_valid(self, form):
        messages.success(self.request, 'Proveedor creado correctamente.')
        return super().form_valid(form)


class ProveedorUpdateView(LoginRequiredMixin, UpdateView):
    model = Proveedor
    template_name = 'proveedores/proveedor_form.html'
    fields = ['nombre', 'ruc', 'contacto', 'telefono', 'email', 'direccion', 'ciudad', 'activo', 'notas']
    success_url = reverse_lazy('proveedores:proveedor_list')

    def form_valid(self, form):
        messages.success(self.request, 'Proveedor actualizado correctamente.')
        return super().form_valid(form)


class ProveedorDetailView(LoginRequiredMixin, DetailView):
    model = Proveedor
    template_name = 'proveedores/proveedor_detail.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['compras'] = self.object.compras.order_by('-fecha')[:10]
        return ctx
