from django.urls import path
from . import views

app_name = 'caja'

urlpatterns = [
    path('', views.CajaView.as_view(), name='caja'),
    path('registrar/', views.registrar_movimiento, name='registrar'),
]
