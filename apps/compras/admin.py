from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin, EmpresaFKMixin
from .models import Compra, DetalleCompra

class DetalleCompraInline(EmpresaFKMixin, admin.TabularInline):
    model = DetalleCompra
    extra = 1

@admin.register(Compra)
class CompraAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['numero', 'proveedor', 'total', 'estado', 'fecha']
    list_filter = ['estado', 'fecha']
    inlines = [DetalleCompraInline]
