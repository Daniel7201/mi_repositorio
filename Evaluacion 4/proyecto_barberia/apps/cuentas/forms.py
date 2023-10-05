from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import Usuario

#Este es el formulario de registro de usuario
class UsuarioAdminCreationForm(UserCreationForm):

    class Meta:
        model = Usuario
        fields = ['first_name', 'last_name', 'rut', 'sexo', 'telefono', 'email', 'username']


class UsuarioAdminForm(forms.ModelForm):

    class Meta:
        model = Usuario
        fields = ['username', 'email', 'is_active', 'is_staff']
