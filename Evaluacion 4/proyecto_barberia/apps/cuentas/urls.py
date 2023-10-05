from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static

#app_name es necesario para utilizar spacename en el modulo urls principal
app_name = 'asd'

urlpatterns = [
    #path(), tiene 3 parametros:
    #Parametro 1: Corresponde a lo que verá el usuario en la url
    #Parametro 2: Corresponde a la view
    #Parametro 3: Corresponde a lo que ve el programador (Asi nos referimos a este path desde los documentos)
    path('', views.index, name="index"),
    path('conectarse/', views.login, name='login'),
    path('desconectarse/', views.logout, name='logout'),
    path('registrarse/', views.register, name='register'),
    path('cambiar-datos/', views.update_user, name='update_user'),
    path('cambiar-password/', views.update_password, name='update_password'),
]
