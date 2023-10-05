from django.shortcuts import render, redirect
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import CreateView, UpdateView, FormView, DetailView
from django.urls import reverse_lazy
from .models import Usuario
from django.contrib.auth.views import (
    LoginView, LogoutView,
    )
from .forms import UsuarioAdminCreationForm
from django.contrib import messages
from django.contrib.auth.forms import PasswordChangeForm, PasswordResetForm
from django.template.loader import render_to_string
from django.utils.http import urlsafe_base64_encode
from django.http import HttpResponse
from django.db.models.query_utils import Q
from django.core.mail import send_mail, BadHeaderError
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes

# Create your views here.

class IndexView(LoginRequiredMixin, DetailView):
    model = Usuario
    #template_name especifica donde buscara el documento
    template_name = 'cuentas/index.html'
    #Con login_url 
    login_url = reverse_lazy('cuentas:login')
    
    def get_object(self):
        return self.request.user

class Login(LoginView):
    model = Usuario
    template_name = 'cuentas/login.html'

class Logout(LogoutView):
    template_name = 'cuentas/logged_out.html'

class RegisterView(CreateView):
    model = Usuario
    template_name = 'cuentas/register.html'
    #Con form_class hacemos uso de nuestro formulario UsuarioAdminCreationForm
    form_class = UsuarioAdminCreationForm
    success_url = reverse_lazy('index')
    
    def form_valid(self, form):
        #Este mensaje se muestra si el formulario está correcto
        messages.info(self.request, "¡Registro completado con éxito! Iniciar sesión.")
        return super().form_valid(form)

def password_reset_request(request):
    if request.method == 'POST':
        form = PasswordResetForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data['email']
            associated_users = Usuario.objects.filter(Q(email=data))
            if associated_users.exists():
                for user in associated_users:
                    subject = "Password Reset Requested"
                    email_template_name = "accounts/password/password_reset_email.txt"
                    c = {
                        "email": user.email,
                        'domain':'127.0.0.1:8000',
                        'site_name': 'Django E-commerce',
                        "uid": urlsafe_base64_encode(force_bytes(user.pk)),
                        "user": user,
                        'token': default_token_generator.make_token(user),
                        'protocol': 'http',
                    }
                    email = render_to_string(email_template_name, c)
                    try:
                        send_mail(
                            subject,
                            email,
                            "admin@exemple.com",
                            [user.email],
                            fail_silently=False
                        )
                    except BadHeaderError:
                        return HttpResponse('Invalid header found.')
                    
                    return redirect('accounts:password_reset_done')
    form = PasswordResetForm()
    return render(
        request=request, 
        template_name="accounts/password/password_reset.html",
        context={
            "form":form,
        })

class UpdateUserView(LoginRequiredMixin, UpdateView):

    model = Usuario
    login_url = reverse_lazy('cuentas:login')
    template_name = 'cuentas/update_user.html'
    fields = ['first_name', 'last_name', 'rut', 'sexo', 'telefono', 'email']
    success_url = reverse_lazy('cuentas:index')

    def get_object(self):
        return self.request.user

class UpdatePasswordView(LoginRequiredMixin, FormView):

    template_name = 'cuentas/update_password.html'
    login_url = reverse_lazy('cuentas:login')
    success_url = reverse_lazy('cuentas:index')
    form_class = PasswordChangeForm

    def get_form_kwargs(self):
        kwargs = super(UpdatePasswordView, self).get_form_kwargs()
        kwargs['user'] = self.request.user
        return kwargs

    def form_valid(self, form):
        form.save()
        return super(UpdatePasswordView, self).form_valid(form)

#Corresponde a las vistas de cada clase
index = IndexView.as_view()
login = Login.as_view()
logout = Logout.as_view()
register = RegisterView.as_view()
update_user = UpdateUserView.as_view()
update_password = UpdatePasswordView.as_view()