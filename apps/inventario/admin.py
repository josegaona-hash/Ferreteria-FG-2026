from django.contrib import admin
from .models import Categoria, UnidadMedida, Producto, MovimientoStock

@admin.register(Categoria)
class CategoriaAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'activo']
    search_fields = ['nombre']

@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'codigo_barras', 'categoria', 'precio_venta', 'stock', 'stock_bajo', 'activo']
    list_filter = ['categoria', 'activo']
    search_fields = ['nombre', 'codigo_barras', 'codigo_interno']
    list_editable = ['stock', 'activo']

@admin.register(MovimientoStock)
class MovimientoStockAdmin(admin.ModelAdmin):
    list_display = ['producto', 'tipo', 'cantidad', 'stock_anterior', 'stock_nuevo', 'fecha']
    list_filter = ['tipo', 'fecha']
    readonly_fields = ['stock_anterior', 'stock_nuevo', 'fecha']

admin.site.register(UnidadMedida)
