from django.db import migrations

MODELOS = [
    ('inventario', 'Categoria'),
    ('inventario', 'UnidadMedida'),
    ('inventario', 'Producto'),
    ('inventario', 'MovimientoStock'),
    ('clientes', 'Cliente'),
    ('proveedores', 'Proveedor'),
    ('compras', 'Compra'),
    ('ventas', 'Venta'),
    ('caja', 'MovimientoCaja'),
]


def asignar_empresa_existente(apps, schema_editor):
    """
    Los datos cargados antes de existir las empresas pasan a una empresa inicial,
    y todos los usuarios existentes quedan asignados a ella.
    """
    Empresa = apps.get_model('empresas', 'Empresa')
    User = apps.get_model('auth', 'User')
    Perfil = apps.get_model('usuarios', 'Perfil')

    hay_datos = User.objects.exists() or any(
        apps.get_model(app, modelo).objects.exists() for app, modelo in MODELOS
    )
    if not hay_datos:
        return

    empresa = Empresa.objects.order_by('id').first() or Empresa.objects.create(nombre='Ferretería FG')
    for app, modelo in MODELOS:
        apps.get_model(app, modelo).objects.filter(empresa__isnull=True).update(empresa=empresa)
    for user in User.objects.all():
        perfil, _ = Perfil.objects.get_or_create(user=user)
        if perfil.empresa_id is None:
            perfil.empresa = empresa
            perfil.save(update_fields=['empresa'])


class Migration(migrations.Migration):

    dependencies = [
        ('empresas', '0001_initial'),
        ('inventario', '0002_empresa'),
        ('clientes', '0002_empresa'),
        ('proveedores', '0002_empresa'),
        ('compras', '0002_empresa'),
        ('ventas', '0002_empresa'),
        ('caja', '0002_empresa'),
        ('usuarios', '0002_empresa'),
    ]

    operations = [
        migrations.RunPython(asignar_empresa_existente, migrations.RunPython.noop),
    ]
