from django.contrib import admin
from .models import Empresa
from .mixins import es_modelo_empresa


@admin.register(Empresa)
class EmpresaAdmin(admin.ModelAdmin):
    list_display = ['nombre', 'ruc', 'plan', 'activa', 'creada']
    list_filter = ['plan', 'activa']
    search_fields = ['nombre', 'ruc']


class EmpresaFKMixin:
    """Muestra en los selects solo los registros de la empresa del usuario."""

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        model = db_field.related_model
        if not request.user.is_superuser and es_modelo_empresa(model):
            kwargs['queryset'] = model._default_manager.filter(empresa=request.empresa)
        return super().formfield_for_foreignkey(db_field, request, **kwargs)


class EmpresaAdminMixin(EmpresaFKMixin):
    """
    Para el admin de modelos con empresa: el superusuario ve todo; el resto de los
    usuarios solo ve y crea registros de su propia empresa.
    """

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        if request.user.is_superuser:
            return qs
        return qs.filter(empresa=request.empresa)

    def get_exclude(self, request, obj=None):
        exclude = list(super().get_exclude(request, obj) or [])
        if not request.user.is_superuser:
            exclude.append('empresa')
        return exclude

    def get_list_display(self, request):
        list_display = list(super().get_list_display(request))
        if request.user.is_superuser:
            list_display.append('empresa')
        return list_display

    def get_list_filter(self, request):
        list_filter = list(super().get_list_filter(request))
        if request.user.is_superuser:
            list_filter.insert(0, 'empresa')
        return list_filter

    def save_model(self, request, obj, form, change):
        if not request.user.is_superuser:
            obj.empresa = request.empresa
        super().save_model(request, obj, form, change)

    def _sin_empresa(self, request):
        return not request.user.is_superuser and request.empresa is None

    def has_module_permission(self, request):
        return not self._sin_empresa(request) and super().has_module_permission(request)

    def has_view_permission(self, request, obj=None):
        return not self._sin_empresa(request) and super().has_view_permission(request, obj)

    def has_add_permission(self, request):
        return not self._sin_empresa(request) and super().has_add_permission(request)

    def has_change_permission(self, request, obj=None):
        return not self._sin_empresa(request) and super().has_change_permission(request, obj)

    def has_delete_permission(self, request, obj=None):
        return not self._sin_empresa(request) and super().has_delete_permission(request, obj)
