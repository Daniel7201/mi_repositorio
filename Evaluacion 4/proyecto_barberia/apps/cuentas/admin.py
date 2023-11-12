from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from .models import Usuario
from .forms import UsuarioAdminCreationForm, UsuarioAdminForm

#Aqui podemos editar el panel de administración

class UsuarioAdmin(BaseUserAdmin):
    add_form = UsuarioAdminCreationForm
    #Corresponde al formulario que realiza el admin para crear un usuario (Se renderiza en el mismo orden)
    add_fieldsets = (
        ('Agregar usuario', {
            'fields': ('first_name', 'last_name', 'rut', 'sexo', 'telefono', 'email', 'username', 'password1', 'password2')
        }),
    )

    form = UsuarioAdminForm
    #Corresponde al formulario que realiza el admin para actualizar un usuario 
    fieldsets = (
        ('Usuario:', {
            'fields': ('username', 'email')
        }),
        ('Informaciones basicas: ', {
            'fields': ('first_name', 'last_name', 'sexo', 'rut', 'telefono', 'last_login')
        }),
        ('Permisos: ', {
            'fields': (
                'is_active', 'is_staff', 'is_superuser', 'user_permissions'
            )
        }),
    )
    list_display = ['username', 'email', 'is_active', 'is_staff', 'date_joined']

#Aqui aplicamos los cambios, pasandole el modelo y la clase que creamos recien
admin.site.register(Usuario, UsuarioAdmin)
