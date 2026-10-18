from django.db import models
from apps.empresas.models import ModeloEmpresa

class Categoria(ModeloEmpresa):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField(blank=True)
    activo = models.BooleanField(default=True)

    class Meta:
        verbose_name = 'Categoría'
        verbose_name_plural = 'Categorías'
        ordering = ['nombre']
        constraints = [
            models.UniqueConstraint(fields=['empresa', 'nombre'], name='categoria_nombre_unico_por_empresa'),
        ]

    def __str__(self):
        return self.nombre


class UnidadMedida(ModeloEmpresa):
    nombre = models.CharField(max_length=50)
    abreviatura = models.CharField(max_length=10)

    class Meta:
        verbose_name = 'Unidad de Medida'
        verbose_name_plural = 'Unidades de Medida'

    def __str__(self):
        return f"{self.nombre} ({self.abreviatura})"


class Producto(ModeloEmpresa):
    codigo_barras = models.CharField(max_length=50, blank=True, db_index=True)
    codigo_interno = models.CharField(max_length=30, blank=True, null=True)
    nombre = models.CharField(max_length=200, db_index=True)
    descripcion = models.TextField(blank=True)
    categoria = models.ForeignKey(Categoria, on_delete=models.SET_NULL, null=True, blank=True, related_name='productos')
    unidad_medida = models.ForeignKey(UnidadMedida, on_delete=models.SET_NULL, null=True, blank=True)
    precio_costo = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    precio_venta = models.DecimalField(max_digits=14, decimal_places=0)
    precio_mayorista = models.DecimalField(max_digits=14, decimal_places=0, default=0)
    stock = models.IntegerField(default=0)
    stock_minimo = models.IntegerField(default=5)
    imagen = models.ImageField(upload_to='productos/', blank=True, null=True)
    activo = models.BooleanField(default=True)
    creado = models.DateTimeField(auto_now_add=True)
    actualizado = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'
        ordering = ['nombre']
        constraints = [
            models.UniqueConstraint(
                fields=['empresa', 'codigo_interno'], name='producto_codigo_interno_unico_por_empresa',
                violation_error_message='Ya existe un producto con este código interno.',
            ),
        ]

    def __str__(self):
        return self.nombre

    @property
    def stock_bajo(self):
        return self.stock <= self.stock_minimo

    @property
    def margen_ganancia(self):
        if self.precio_costo > 0:
            return ((self.precio_venta - self.precio_costo) / self.precio_costo) * 100
        return 0


class MovimientoStock(ModeloEmpresa):
    TIPO_CHOICES = [
        ('entrada', 'Entrada'),
        ('salida', 'Salida'),
        ('ajuste', 'Ajuste'),
        ('devolucion', 'Devolución'),
    ]
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE, related_name='movimientos')
    tipo = models.CharField(max_length=15, choices=TIPO_CHOICES)
    cantidad = models.IntegerField()
    stock_anterior = models.IntegerField()
    stock_nuevo = models.IntegerField()
    motivo = models.CharField(max_length=200, blank=True)
    fecha = models.DateTimeField(auto_now_add=True)
    usuario = models.ForeignKey('auth.User', on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        verbose_name = 'Movimiento de Stock'
        verbose_name_plural = 'Movimientos de Stock'
        ordering = ['-fecha']

    def __str__(self):
        return f"{self.tipo} - {self.producto.nombre} ({self.cantidad})"
