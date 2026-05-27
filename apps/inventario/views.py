from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, CreateView, UpdateView, DeleteView, DetailView
from django.urls import reverse_lazy
from django.contrib import messages
from django.db.models import Q
from .models import Producto, Categoria, UnidadMedida, MovimientoStock


class ProductoListView(LoginRequiredMixin, ListView):
    model = Producto
    template_name = 'inventario/producto_list.html'
    context_object_name = 'productos'
    paginate_by = 20

    def get_queryset(self):
        qs = Producto.objects.select_related('categoria', 'unidad_medida').filter(activo=True)
        q = self.request.GET.get('q')
        categoria = self.request.GET.get('categoria')
        if q:
            qs = qs.filter(Q(nombre__icontains=q) | Q(codigo_barras__icontains=q) | Q(codigo_interno__icontains=q))
        if categoria:
            qs = qs.filter(categoria_id=categoria)
        return qs

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['categorias'] = Categoria.objects.filter(activo=True)
        ctx['total_productos'] = Producto.objects.filter(activo=True).count()
        ctx['stock_bajo'] = Producto.objects.filter(activo=True, stock__lte=5).count()
        return ctx


class ProductoCreateView(LoginRequiredMixin, CreateView):
    model = Producto
    template_name = 'inventario/producto_form.html'
    fields = ['codigo_barras', 'codigo_interno', 'nombre', 'descripcion', 'categoria',
              'unidad_medida', 'precio_costo', 'precio_venta', 'precio_mayorista',
              'stock', 'stock_minimo', 'imagen']
    success_url = reverse_lazy('inventario:producto_list')

    def form_valid(self, form):
        messages.success(self.request, 'Producto creado correctamente.')
        return super().form_valid(form)


class ProductoUpdateView(LoginRequiredMixin, UpdateView):
    model = Producto
    template_name = 'inventario/producto_form.html'
    fields = ['codigo_barras', 'codigo_interno', 'nombre', 'descripcion', 'categoria',
              'unidad_medida', 'precio_costo', 'precio_venta', 'precio_mayorista',
              'stock', 'stock_minimo', 'imagen', 'activo']
    success_url = reverse_lazy('inventario:producto_list')

    def form_valid(self, form):
        messages.success(self.request, 'Producto actualizado correctamente.')
        return super().form_valid(form)


class ProductoDetailView(LoginRequiredMixin, DetailView):
    model = Producto
    template_name = 'inventario/producto_detail.html'

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx['movimientos'] = MovimientoStock.objects.filter(producto=self.object).order_by('-fecha')[:20]
        return ctx


class CategoriaListView(LoginRequiredMixin, ListView):
    model = Categoria
    template_name = 'inventario/categoria_list.html'
    context_object_name = 'categorias'


class StockBajoListView(LoginRequiredMixin, ListView):
    template_name = 'inventario/stock_bajo.html'
    context_object_name = 'productos'

    def get_queryset(self):
        return Producto.objects.filter(activo=True, stock__lte=5).select_related('categoria')
