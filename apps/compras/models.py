from django.db import models
from django.contrib.auth.models import User

class Compra(models.Model):
    ESTADO_CHOICES = [
        ('pendiente', 'Pendiente'),
        ('recibida', 'Recibida'),
        ('anulada', 'Anulada'),
    ]
    numero = models.CharField(max_length=20, unique=True, blank=True)
    proveedor = models.ForeignKey('proveedores.Proveedor', on_delete=models.PROTECT, related_name='compras')
    fecha = models.DateTimeField(auto_now_add=True)
    fecha_entrega = models.DateField(null=True, blank=True)
    estado = models.CharField(max_length=15, choices=ESTADO_CHOICES, default='pendiente')
    total = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    observacion = models.TextField(blank=True)
    usuario = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)

    class Meta:
        verbose_name = 'Compra'
        verbose_name_plural = 'Compras'
        ordering = ['-fecha']

    def __str__(self):
        return f"Compra #{self.numero or self.id}"

    def save(self, *args, **kwargs):
        if not self.numero:
            last = Compra.objects.order_by('-id').first()
            n = (last.id + 1) if last else 1
            self.numero = f"C{n:06d}"
        super().save(*args, **kwargs)


class DetalleCompra(models.Model):
    compra = models.ForeignKey(Compra, on_delete=models.CASCADE, related_name='detalles')
    producto = models.ForeignKey('inventario.Producto', on_delete=models.PROTECT)
    cantidad = models.IntegerField()
    precio_unitario = models.DecimalField(max_digits=14, decimal_places=0)
    subtotal = models.DecimalField(max_digits=14, decimal_places=0)

    def save(self, *args, **kwargs):
        self.subtotal = self.precio_unitario * self.cantidad
        super().save(*args, **kwargs)
