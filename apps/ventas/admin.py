from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin, EmpresaFKMixin
from .models import Venta, DetalleVenta

class DetalleVentaInline(EmpresaFKMixin, admin.TabularInline):
    model = DetalleVenta
    extra = 0
    readonly_fields = ['subtotal']

@admin.register(Venta)
class VentaAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['numero', 'cliente', 'total', 'forma_pago', 'estado', 'fecha', 'usuario']
    list_filter = ['estado', 'forma_pago', 'fecha']
    search_fields = ['numero', 'cliente__nombre']
    inlines = [DetalleVentaInline]
    readonly_fields = ['numero', 'fecha', 'usuario']
