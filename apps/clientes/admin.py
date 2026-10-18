from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin
from .models import Cliente

@admin.register(Cliente)
class ClienteAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['nombre', 'ruc', 'telefono', 'email', 'activo']
    search_fields = ['nombre', 'ruc', 'telefono']
    list_filter = ['activo', 'ciudad']
