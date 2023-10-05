from django.contrib import admin
from apps.barberos.models import Servicio, Barbero

class ServicioAdmin(admin.ModelAdmin):
    list_display = ['nombre']

class BarberoAdmin(admin.ModelAdmin):
    list_display = [
        'nombre', 'rut', 'email', 'telefono', 'servicio'
    ]
    
admin.site.register(Servicio, ServicioAdmin)
admin.site.register(Barbero, BarberoAdmin)