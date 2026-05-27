from django.urls import path
from . import views

app_name = 'ventas'

urlpatterns = [
    path('', views.DashboardView.as_view(), name='dashboard'),
    path('pos/', views.PosView.as_view(), name='pos'),
    path('historial/', views.VentaListView.as_view(), name='venta_list'),
    path('historial/<int:pk>/', views.VentaDetailView.as_view(), name='venta_detail'),
    path('api/buscar-producto/', views.buscar_producto, name='buscar_producto'),
    path('api/crear/', views.crear_venta, name='crear_venta'),
]
