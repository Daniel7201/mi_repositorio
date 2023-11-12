from django.views.generic import CreateView, ListView, UpdateView, DeleteView
from django.urls import reverse_lazy
from django.shortcuts import redirect
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from .models import Barbero, Servicio, Horario
from apps.cuentas.models import Usuario

# Create your views here.
class TestMixinIsAdmin(UserPassesTestMixin):
    def test_func(self):
        is_admin_or_is_staff = self.request.user.is_superuser or \
            self.request.user.is_staff
        return bool(is_admin_or_is_staff)

    def handle_no_permission(self):
        messages.error(
            self.request, "¡No tienes permisos!"
        )
        return redirect("cuentas:index")

class UsuarioListView(LoginRequiredMixin, TestMixinIsAdmin, ListView):
    
    login_url = 'cuentas:login'
    template_name = 'barberos/usuarios_list.html'

    def get_queryset(self):
        return Usuario.objects.all().order_by('-pk')

class BarberoCreateView(LoginRequiredMixin, TestMixinIsAdmin, CreateView):

    model = Barbero
    login_url = 'cuentas:login'
    template_name = 'barberos/barberos_create.html'
    fields = ['nombre', 'rut', 'email', 'telefono', 'servicio']
    success_url = reverse_lazy('barberos:barberos_list')

class BarberoListView(LoginRequiredMixin, TestMixinIsAdmin, ListView):
    
    login_url = 'cuentas:login'
    template_name = 'barberos/barberos_list.html'

    def get_queryset(self):
        return Barbero.objects.all().order_by('-pk')


class HorarioCreateView(LoginRequiredMixin, TestMixinIsAdmin, CreateView):

    model = Horario
    login_url = 'cuentas:login'
    template_name = 'barberos/barberos_create.html'
    fields = ['desde', 'hasta']
    success_url = reverse_lazy('barberos:horarios_list')

class HorarioListView(LoginRequiredMixin, TestMixinIsAdmin, ListView):
    
    login_url = 'cuentas:login'
    template_name = 'barberos/horarios_list.html'

    def get_queryset(self):
        return Horario.objects.all().order_by('-pk')

class ServicioCreateView(LoginRequiredMixin, TestMixinIsAdmin, CreateView):

    model = Servicio
    login_url = 'cuentas:login'
    template_name = 'barberos/barberos_create.html'
    fields = ['nombre', 'precio']
    success_url = reverse_lazy('barberos:servicios_list')
    
class ServicioListView(LoginRequiredMixin, TestMixinIsAdmin, ListView):
    
    login_url = 'accounts:login'
    template_name = 'barberos/servicios_list.html'

    def get_queryset(self):
        return Servicio.objects.all().order_by('-pk')

barberos_create = BarberoCreateView.as_view()
barberos_list = BarberoListView.as_view()
servicios_create = ServicioCreateView.as_view()
servicios_list = ServicioListView.as_view()
horarios_create = HorarioCreateView.as_view()
horarios_list = HorarioListView.as_view()
usuarios_list = UsuarioListView.as_view()