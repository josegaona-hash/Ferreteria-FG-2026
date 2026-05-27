from django.contrib import admin
from .models import MovimientoCaja

@admin.register(MovimientoCaja)
class MovimientoCajaAdmin(admin.ModelAdmin):
    list_display = ['tipo', 'descripcion', 'monto', 'fecha', 'usuario']
    list_filter = ['tipo', 'fecha']
    readonly_fields = ['fecha']
