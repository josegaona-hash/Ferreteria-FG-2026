from django.contrib import admin
from .models import Proveedor

@admin.register(Proveedor)
class ProveedorAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'ruc', 'contacto', 'telefono', 'activo']
    search_fields = ['nombre', 'ruc']
