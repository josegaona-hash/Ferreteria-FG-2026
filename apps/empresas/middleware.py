from apps.usuarios.models import Perfil


class EmpresaMiddleware:
    """Guarda en request.empresa la empresa activa del usuario conectado (o None)."""

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        request.empresa = None
        if request.user.is_authenticated:
            perfil = Perfil.objects.select_related('empresa').filter(user=request.user).first()
            if perfil and perfil.empresa and perfil.empresa.activa:
                request.empresa = perfil.empresa
        return self.get_response(request)
