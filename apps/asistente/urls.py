from django.urls import path
from . import views

app_name = 'asistente'

urlpatterns = [
    path('', views.ChatView.as_view(), name='chat'),
    path('api/preguntar/', views.preguntar, name='preguntar'),
]
