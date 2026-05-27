from django.urls import path
from . import views

app_name = 'reportes'

urlpatterns = [
    path('ventas/', views.ReporteVentasView.as_view(), name='ventas'),
    path('inventario/', views.ReporteInventarioView.as_view(), name='inventario'),
    path('caja/', views.ReporteCajaView.as_view(), name='caja'),
]
