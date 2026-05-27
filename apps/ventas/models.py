from django.db import models
from django.contrib.auth.models import User

class Venta(models.Model):
    ESTADO_CHOICES = [
        ('pagada', 'Pagada'),
        ('pendiente', 'Pendiente'),
        ('anulada', 'Anulada'),
    ]
    PAGO_CHOICES = [
        ('contado', 'Contado'),
        ('tarjeta', 'Tarjeta'),
        ('transferencia', 'Transferencia'),
        ('credito', 'Crédito'),
    ]
    numero = models.CharField(max_length=20, unique=True, blank=True)
    cliente = models.ForeignKey('clientes.Cliente', on_delete=models.SET_NULL, null=True, blank=True, related_name='ventas')
    fecha = models.DateTimeField(auto_now_add=True)
    forma_pago = models.CharField(max_length=20, choices=PAGO_CHOICES, default='contado')
    estado = models.CharField(max_length=15, choices=ESTADO_CHOICES, default='pagada')
    subtotal = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    iva = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    total = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    observacion = models.TextField(blank=True)
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        verbose_name = 'Venta'
        verbose_name_plural = 'Ventas'
        ordering = ['-fecha']

    def __str__(self):
        return f"Venta #{self.numero or self.id}"

    def save(self, *args, **kwargs):
        if not self.numero:
            last = Venta.objects.order_by('-id').first()
            n = (last.id + 1) if last else 1
            self.numero = f"V{n:06d}"
        super().save(*args, **kwargs)


class DetalleVenta(models.Model):
    venta = models.ForeignKey(Venta, on_delete=models.CASCADE, related_name='detalles')
    producto = models.ForeignKey('inventario.Producto', on_delete=models.PROTECT)
    cantidad = models.IntegerField()
    precio_unitario = models.DecimalField(max_digits=14, decimal_places=0)
    subtotal = models.DecimalField(max_digits=14, decimal_places=0)

    class Meta:
        verbose_name = 'Detalle de Venta'
        verbose_name_plural = 'Detalles de Venta'

    def __str__(self):
        return f"{self.producto.nombre} x {self.cantidad}"

    def save(self, *args, **kwargs):
        self.subtotal = self.precio_unitario * self.cantidad
        super().save(*args, **kwargs)
