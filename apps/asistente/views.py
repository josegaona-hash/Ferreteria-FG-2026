from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.views.generic import TemplateView
import json
import logging

from .ia import AsistenteError, responder

logger = logging.getLogger(__name__)


class ChatView(LoginRequiredMixin, TemplateView):
    template_name = 'asistente/chat.html'


@login_required
@require_POST
def preguntar(request):
    try:
        data = json.loads(request.body)
        historial = data.get('mensajes', [])
        if not isinstance(historial, list):
            return JsonResponse({'error': 'Formato inválido'}, status=400)
        return JsonResponse(responder(historial))
    except json.JSONDecodeError:
        return JsonResponse({'error': 'Formato inválido'}, status=400)
    except AsistenteError as e:
        return JsonResponse({'error': str(e)}, status=400)
    except Exception:
        logger.exception('Error en el asistente de ventas')
        return JsonResponse({'error': 'Ocurrió un error inesperado en el asistente.'}, status=500)
