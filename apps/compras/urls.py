from django.urls import path
from . import views

app_name = 'compras'

urlpatterns = [
    path('', views.CompraListView.as_view(), name='compra_list'),
    path('<int:pk>/', views.CompraDetailView.as_view(), name='compra_detail'),
]
