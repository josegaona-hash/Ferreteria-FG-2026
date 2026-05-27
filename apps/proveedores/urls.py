from django.urls import path
from . import views

app_name = 'proveedores'

urlpatterns = [
    path('', views.ProveedorListView.as_view(), name='proveedor_list'),
    path('nuevo/', views.ProveedorCreateView.as_view(), name='proveedor_create'),
    path('<int:pk>/editar/', views.ProveedorUpdateView.as_view(), name='proveedor_update'),
    path('<int:pk>/detalle/', views.ProveedorDetailView.as_view(), name='proveedor_detail'),
]
