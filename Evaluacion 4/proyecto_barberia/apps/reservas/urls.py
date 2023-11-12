from django.urls import path
from . import views

app_name = 'reservas'

urlpatterns = [
	path('reservar/', views.reservas_create, name='reservas_create'),
	path('mis-reservas/', views.reservas_list, name='reservas_list'),
	path('mis-reservas/editar/<int:pk>/', views.reservas_update, name='reservas_update'),
	path('consultas/eliminar/<int:pk>/', views.reservas_delete, name='reservas_delete'),
	path('admin/lista/reservaciones', views.reservaciones_list, name='reservaciones_list'),
]