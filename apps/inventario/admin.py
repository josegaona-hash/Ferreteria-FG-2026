from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin
from .models import Categoria, UnidadMedida, Producto, MovimientoStock

@admin.register(Categoria)
class CategoriaAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['nombre', 'activo']
    search_fields = ['nombre']

@admin.register(Producto)
class ProductoAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['nombre', 'codigo_barras', 'categoria', 'precio_venta', 'stock', 'stock_bajo', 'activo']
    list_filter = [('categoria', admin.RelatedOnlyFieldListFilter), 'activo']
    search_fields = ['nombre', 'codigo_barras', 'codigo_interno']
    list_editable = ['stock', 'activo']

@admin.register(MovimientoStock)
class MovimientoStockAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['producto', 'tipo', 'cantidad', 'stock_anterior', 'stock_nuevo', 'fecha']
    list_filter = ['tipo', 'fecha']
    readonly_fields = ['stock_anterior', 'stock_nuevo', 'fecha']

@admin.register(UnidadMedida)
class UnidadMedidaAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['nombre', 'abreviatura']
