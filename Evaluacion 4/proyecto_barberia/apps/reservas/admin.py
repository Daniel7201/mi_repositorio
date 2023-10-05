from django.contrib import admin
from .models import Horario, Reserva

    
class HorarioAdmin(admin.ModelAdmin):
    list_display = [
        'desde', 'hasta',
    ]
    
class ReservaAdmin(admin.ModelAdmin):
    list_display = [
        'barbero', 'dia', 'horario', 'usuario'
    ]
    
    
admin.site.register(Horario, HorarioAdmin)
admin.site.register(Reserva, ReservaAdmin)