from django.contrib.auth.views import LoginView, LogoutView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import TemplateView


class CustomLoginView(LoginView):
    template_name = 'registration/login.html'


class PerfilView(LoginRequiredMixin, TemplateView):
    template_name = 'usuarios/perfil.html'
