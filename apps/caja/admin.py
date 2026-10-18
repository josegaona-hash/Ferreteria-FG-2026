from django.contrib import admin
from apps.empresas.admin import EmpresaAdminMixin
from .models import MovimientoCaja

@admin.register(MovimientoCaja)
class MovimientoCajaAdmin(EmpresaAdminMixin, admin.ModelAdmin):
    list_display = ['tipo', 'descripcion', 'monto', 'fecha', 'usuario']
    list_filter = ['tipo', 'fecha']
    readonly_fields = ['fecha']
