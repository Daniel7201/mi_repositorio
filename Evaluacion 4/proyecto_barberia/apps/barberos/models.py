from django.db import models
from django.core.validators import RegexValidator
from itertools import cycle
from django.core.exceptions import ValidationError

class Horario(models.Model):
    desde =  models.TimeField(auto_now=False, auto_now_add=False, help_text="La hora debe estar en este formato: 14:00 o 14:00:00")
    hasta = models.TimeField(auto_now=False, auto_now_add=False, help_text="La hora debe estar en este formato: 15:30 o 15:30:00")

    def __str__(self):
        return f'{self.desde} - {self.hasta}'

class Servicio(models.Model):
    nombre = models.CharField(verbose_name="Nombre", max_length=200, unique=True,)
    precio = models.IntegerField(verbose_name="Precio")
    
    def __str__(self):
        return f'{self.nombre} - {self.precio}'

def validarRut(rut):
    rut = rut.upper()
    rut = rut.replace("-","")
    rut = rut.replace(".","")
    aux = rut[:-1]
    dv = rut[-1:]
    error = False

    if len(rut) != 9:
        error = True
    if aux.isalpha() == True:
        error = True
    if dv.isalpha() == True:
        if dv != "K":
            error = True

    if error:
        raise ValidationError('Ingrese un rut valido. Ej: 22755865-K')

class Barbero(models.Model):
    nombre = models.CharField(verbose_name="Nombre", max_length=200)
    rut = models.CharField(verbose_name="RUT", max_length=15, validators=[validarRut], help_text="Ingrese un rut valido. Ej: 22755865-K")
    email = models.EmailField(verbose_name="Email")
    telefono_regex = RegexValidator(
    regex=r'^\+?1?\d{9,15}$',
    message="El número debe estar en este formato: 933789228")

    telefono = models.CharField(verbose_name="Telefono",
                                validators=[telefono_regex],
                                max_length=17, null=False)
    servicio = models.ForeignKey(Servicio,
                               on_delete=models.CASCADE,
                               related_name='barbero')

    class Meta:
        unique_together = ('rut', 'servicio')
    
    def __str__(self):
        return f'{self.nombre} - {self.rut}'