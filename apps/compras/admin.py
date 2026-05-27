from django.contrib import admin
from .models import Compra, DetalleCompra

class DetalleCompraInline(admin.TabularInline):
    model = DetalleCompra
    extra = 1

@admin.register(Compra)
class CompraAdmin(admin.ModelAdmin):
    list_display = ['numero', 'proveedor', 'total', 'estado', 'fecha']
    list_filter = ['estado', 'fecha']
    inlines = [DetalleCompraInline]
