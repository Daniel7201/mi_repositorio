from django.db import models
from django.db.models.fields.related import ForeignKey
from apps.barberos.models import Barbero, Horario
from apps.cuentas.models import Usuario
from datetime import date
from django.core.exceptions import ValidationError

# Create your models here.

def validar_dia(value):
    today = date.today()
    weekday = date.fromisoformat(f'{value}').weekday()

    if value < today:
        raise ValidationError('No es posible elegir una fecha tardía.')
    if (weekday == 5) or (weekday == 6):
        raise ValidationError('Elija un día laborable de la semana.')

class Reserva(models.Model):
    barbero = ForeignKey(Barbero, on_delete=models.CASCADE, related_name='reserva')
    dia = models.DateField(help_text="Selecciona un dia en el calendario", validators=[validar_dia])
    horario = models.ForeignKey(Horario, on_delete=models.CASCADE, related_name='reserva')
    usuario = ForeignKey(Usuario, on_delete=models.CASCADE, related_name='reserva')
    
    class Meta:
        unique_together = ('barbero', 'dia', 'horario')
        
    def __str__(self):
        return f'{self.barbero} - {self.dia} - {self.horario} - {self.usuario}'
