from django.shortcuts import render
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import CreateView, ListView, UpdateView, DeleteView
from django.urls import reverse_lazy
from django.contrib import messages
from django.http import HttpResponseRedirect
from .models import Reserva
from django.db import IntegrityError

# Create your views here.
class ReservaCreateView(LoginRequiredMixin, CreateView):

    model = Reserva
    login_url = 'cuentas:login'
    template_name = 'reservas/reservas_create.html'
    fields = ['barbero', 'dia', 'horario']
    success_url = reverse_lazy('reservas:reservas_list')
    
    def form_valid(self, form):
        try:
            form.instance.usuario = self.request.user
            return super().form_valid(form)
        except IntegrityError as e:
            if 'UNIQUE constraint failed' in e.args[0]:
                messages.warning(self.request, 'Error. Ya se ha realizado una reservación con los mismos parametros.')
                return HttpResponseRedirect(reverse_lazy('reservas:reservas_create'))

class ReservaListView(LoginRequiredMixin, ListView):
    
    login_url = 'cuentas:login'
    template_name = 'reservas/reservas_list.html'

    def get_queryset(self):
        try:
            reservas = Reserva.objects.filter(usuario=self.request.user).order_by('-pk')
        	#Si no existe una reservación de este usuario, salta el siguiente mensaje
        except Reserva.DoesNotExist:
            messages.warning(self.request, 'Has una reserva')
            return None
        return reservas

class ReservaUpdateView(LoginRequiredMixin, UpdateView):

    model = Reserva
    login_url = 'accounts:login'
    template_name = 'reservas/reservas_create.html'
    fields = ['barbero', 'dia', 'horario']
    success_url = reverse_lazy('reservas:reservas_list')
    
    def form_valid(self, form):
        form.instance.usuario = user=self.request.user
        return super().form_valid(form)

class ReservaDeleteView(LoginRequiredMixin, DeleteView):
    model = Reserva
    success_url = reverse_lazy('reservas:reservas_list')
    template_name = 'reservas/reservas_delete.html'

    def get_success_url(self):
        messages.success(self.request, "!Reserva eliminada con éxito!")
        return reverse_lazy('reservas:reservas_list')


class ReservacionesListView(LoginRequiredMixin, ListView):

    login_url = 'cuentas:login'
    template_name = 'reservas/reservaciones_list.html'

    def get_queryset(self):
        return Reserva.objects.all().order_by('-pk')

reservas_create = ReservaCreateView.as_view()
reservas_list = ReservaListView.as_view()
reservas_update = ReservaUpdateView.as_view()
reservas_delete = ReservaDeleteView.as_view()
reservaciones_list = ReservacionesListView.as_view()

"""

try:
            form.instance.usuario = Reserva.objects.get(usuario=self.request.user)
            form.save()
        #Este error aparece cuando existe un registro con los mismo campos
        except IntegrityError as e:
            if 'UNIQUE constraint failed' in e.args[0]:
                messages.warning(self.request, 'Error. Ya se ha realizado una reservación con los mismos parametros.')
                return HttpResponseRedirect(reverse_lazy('reservas:reservas_create'))
        except Reserva.DoesNotExist:
            messages.warning(self.request, 'Error. La reservación no se pudo realizar')
            return HttpResponseRedirect(reverse_lazy('reservas:reservas_list'))

        messages.info(self.request, 'Su reservación se ha realizado correctamente!')
        return HttpResponseRedirect(reverse_lazy('reservas:reservas_list'))
"""