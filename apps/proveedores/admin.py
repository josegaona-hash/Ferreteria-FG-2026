from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin
from .models import Proveedor

@admin.register(Proveedor)
class ProveedorAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['nombre', 'ruc', 'contacto', 'telefono', 'activo']
    search_fields = ['nombre', 'ruc']
