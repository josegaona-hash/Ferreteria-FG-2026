from functools import wraps

from django import forms
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.core.exceptions import ValidationError
from django.forms import modelform_factory
from django.shortcuts import render


def es_modelo_empresa(model):
    return any(f.name == 'empresa' for f in model._meta.get_fields())


def respuesta_sin_empresa(request):
    return render(request, 'empresas/sin_empresa.html', status=403)


def empresa_requerida(view):
    """Como login_required, pero además exige que el usuario tenga una empresa activa."""
    @login_required
    @wraps(view)
    def wrapper(request, *args, **kwargs):
        if request.empresa is None:
            return respuesta_sin_empresa(request)
        return view(request, *args, **kwargs)
    return wrapper


class EmpresaModelForm(forms.ModelForm):
    """Valida las restricciones únicas por empresa aunque 'empresa' no esté en el formulario."""

    def validate_unique(self):
        exclude = self._get_validation_exclusions() - {'empresa'}
        try:
            self.instance.validate_unique(exclude=exclude)
            self.instance.validate_constraints(exclude=exclude)
        except ValidationError as e:
            self._update_errors(e)


class EmpresaMixin(LoginRequiredMixin):
    """Limita las vistas a los datos de la empresa del usuario conectado."""

    def dispatch(self, request, *args, **kwargs):
        if not request.user.is_authenticated:
            return self.handle_no_permission()
        if request.empresa is None:
            return respuesta_sin_empresa(request)
        return super().dispatch(request, *args, **kwargs)

    def get_queryset(self):
        return super().get_queryset().filter(empresa=self.request.empresa)

    def get_form_class(self):
        if self.form_class is None and self.fields is not None:
            return modelform_factory(self.model, form=EmpresaModelForm, fields=self.fields)
        return super().get_form_class()

    def get_form(self, form_class=None):
        form = super().get_form(form_class)
        form.instance.empresa = self.request.empresa
        for field in form.fields.values():
            qs = getattr(field, 'queryset', None)
            if qs is not None and es_modelo_empresa(qs.model):
                field.queryset = qs.filter(empresa=self.request.empresa)
        return form
