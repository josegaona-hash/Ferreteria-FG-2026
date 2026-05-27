from django.contrib import admin
from .models import Venta, DetalleVenta

class DetalleVentaInline(admin.TabularInline):
    model = DetalleVenta
    extra = 0
    readonly_fields = ['subtotal']

@admin.register(Venta)
class VentaAdmin(admin.ModelAdmin):
    list_display = ['numero', 'cliente', 'total', 'forma_pago', 'estado', 'fecha', 'usuario']
    list_filter = ['estado', 'forma_pago', 'fecha']
    search_fields = ['numero', 'cliente__nombre']
    inlines = [DetalleVentaInline]
    readonly_fields = ['numero', 'fecha', 'usuario']
