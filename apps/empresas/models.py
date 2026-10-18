from django.db import models


class Empresa(models.Model):
    PLAN_CHOICES = [
        ('basico', 'Básico'),
        ('comercio', 'Comercio'),
        ('pro', 'Pro'),
    ]
    nombre = models.CharField(max_length=200)
    ruc = models.CharField(max_length=20, blank=True)
    telefono = models.CharField(max_length=30, blank=True)
    email = models.EmailField(blank=True)
    direccion = models.CharField(max_length=255, blank=True)
    plan = models.CharField(max_length=15, choices=PLAN_CHOICES, default='basico')
    activa = models.BooleanField(default=True, help_text='Desmarcar para suspender el acceso (por ejemplo, por falta de pago).')
    creada = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = 'Empresa'
        verbose_name_plural = 'Empresas'
        ordering = ['nombre']

    def __str__(self):
        return self.nombre


class ModeloEmpresa(models.Model):
    """Base para los modelos cuyos datos pertenecen a una sola empresa."""
    empresa = models.ForeignKey(Empresa, on_delete=models.PROTECT)

    class Meta:
        abstract = True
