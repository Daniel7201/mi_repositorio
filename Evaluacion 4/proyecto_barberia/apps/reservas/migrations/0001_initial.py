# Generated by Django 4.1.1 on 2022-12-13 20:42

import apps.reservas.models
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('barberos', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Reserva',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('dia', models.DateField(help_text='Selecciona un dia en el calendario', validators=[apps.reservas.models.validar_dia])),
                ('barbero', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reserva', to='barberos.barbero')),
                ('horario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reserva', to='barberos.horario')),
                ('usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reserva', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'unique_together': {('barbero', 'dia', 'horario')},
            },
        ),
    ]
