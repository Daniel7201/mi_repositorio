"""proyecto_barberia URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.IndexView.as_view(), name="index"),
    #path(), tiene 3 parametros:
    #Parametro 1: Corresponde a lo que verá el usuario en la url
    #Parametro 2: Corresponde a la view
    #Parametro 3: Corresponde a lo que ve el programador (Asi nos referimos al conjunto de paths de una app)
    path('cuenta/', include('apps.cuentas.urls', namespace='cuentas')),
    path('reserva/', include('apps.reservas.urls', namespace='reservas')),
    path('barbero/', include('apps.barberos.urls', namespace='barberos')),
]
