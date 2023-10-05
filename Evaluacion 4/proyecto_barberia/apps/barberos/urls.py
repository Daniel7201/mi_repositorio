from django.urls import path
from . import views

app_name = 'medicos'

urlpatterns = [
    path('admin/lista/usuarios/', views.usuarios_list, name="usuarios_list"),
    path('registro/barberos/', views.barberos_create, name='barberos_create'),
    path('admin/lista/barberos/', views.barberos_list, name="barberos_list"),
    path('registro/servicios/', views.servicios_create, name='servicios_create'),
    path('admin/lista/servicios/', views.servicios_list, name="servicios_list"),
    path('registro/horarios/', views.horarios_create, name='horarios_create'),
    path('admin/lista/horarios/', views.horarios_list, name="horarios_list"),
]