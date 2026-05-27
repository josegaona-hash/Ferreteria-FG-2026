from django.urls import path
from . import views

app_name = 'inventario'

urlpatterns = [
    path('', views.ProductoListView.as_view(), name='producto_list'),
    path('nuevo/', views.ProductoCreateView.as_view(), name='producto_create'),
    path('<int:pk>/editar/', views.ProductoUpdateView.as_view(), name='producto_update'),
    path('<int:pk>/detalle/', views.ProductoDetailView.as_view(), name='producto_detail'),
    path('categorias/', views.CategoriaListView.as_view(), name='categoria_list'),
    path('stock-bajo/', views.StockBajoListView.as_view(), name='stock_bajo'),
]
