import re
from django.db import models
from django.core import validators
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, UserManager
from django.core.validators import RegexValidator
from itertools import cycle
from django.core.exceptions import ValidationError

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

class Usuario(AbstractBaseUser, PermissionsMixin):
    
    username = models.CharField(
        'Usuario', max_length=30, unique=True, validators=[
            validators.RegexValidator(
                re.compile('^[\w.@+-]+$'),
                'Ingrese un nombre de usuario valido. '
                'Este valor debe contener solo letras, números '
                'y los caracteres: @/./+/-/_.'
                ,  'invalid'
            )
        ], help_text='Un nombre corto que será usado'+
                    ' para identificarlo de forma única en la plataforma.'
    )

    first_name = models.CharField('Nombre', max_length=150)
    last_name = models.CharField('Apellido', max_length=150)
    email = models.EmailField('Email', unique=True)
    is_staff = models.BooleanField('Equipo', default=False)
    is_active = models.BooleanField('Activo', default=True)
    date_joined = models.DateTimeField('Fecha de Ingreso', auto_now_add=True)

    SEXO = (
        ("MAS", "Masculino"),
        ("FEM", "Femenino")
    )
    
    sexo = models.CharField(max_length=9, choices=SEXO,)

    phone_regex = RegexValidator(
        regex=r'^\+?1?\d{9,15}$',
        message="El número debe estar en este formato: 933789228.")

    telefono = models.CharField(verbose_name="Telefono",
                                validators=[phone_regex],
                                max_length=9, null=False, help_text='El número debe estar en este formato: 933789228')

    rut = models.CharField(verbose_name="RUT", max_length=10, validators=[validarRut], unique=True, help_text='Ingrese un rut valido. Ej: 22755865-K')

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['first_name', 'last_name', 'email', 'sexo', 'telefono', 'rut']

    objects = UserManager()

    class Meta:
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'

    def __str__(self):
        return self.username
    
"""def get_full_name(self):
    return str(self)

def get_short_name(self):
    return str(self).split(' ')[0]"""
