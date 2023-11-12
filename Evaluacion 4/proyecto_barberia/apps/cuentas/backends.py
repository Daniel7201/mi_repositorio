from django.contrib.auth.backends import ModelBackend as BaseBackend
from .models import Usuario


class ModelBackend(BaseBackend):

    #Aca verificamos si las credenciales son correctas
    #Ademas permitimos que el usuario ingrese con su correo
    def authenticate(self,request, username=None, password=None):
        if not username is None:
            try:
                user = Usuario.objects.get(email=username)
                if user.check_password(password):
                    return user
            except Usuario.DoesNotExist:
                pass
