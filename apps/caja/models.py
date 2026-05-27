from django.db import models
from django.contrib.auth.models import User

class MovimientoCaja(models.Model):
    TIPO_CHOICES = [('ingreso', 'Ingreso'), ('egreso', 'Egreso')]
    tipo = models.CharField(max_length=10, choices=TIPO_CHOICES)
    descripcion = models.CharField(max_length=255)
    monto = models.DecimalField(max_digits=14, decimal_places=0)
    fecha = models.DateTimeField(auto_now_add=True)
    venta = models.OneToOneField('ventas.Venta', on_delete=models.SET_NULL, null=True, blank=True)
    compra = models.OneToOneField('compras.Compra', on_delete=models.SET_NULL, null=True, blank=True)
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        verbose_name = 'Movimiento de Caja'
        verbose_name_plural = 'Movimientos de Caja'
        ordering = ['-fecha']

    def __str__(self):
        return f"{self.tipo} - {self.descripcion} ({self.monto})"
