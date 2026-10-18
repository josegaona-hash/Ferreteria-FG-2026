from getpass import getpass

from django.contrib.auth.models import Group, Permission, User
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction

from apps.empresas.models import Empresa
from apps.inventario.models import UnidadMedida
from apps.usuarios.models import Perfil

GRUPO_ADMIN_EMPRESA = 'Administrador de empresa'
APPS_DE_EMPRESA = ['inventario', 'clientes', 'proveedores', 'compras', 'ventas', 'caja']
UNIDADES_INICIALES = [
    ('Unidad', 'un'),
    ('Metro', 'm'),
    ('Kilogramo', 'kg'),
    ('Litro', 'l'),
    ('Caja', 'cj'),
    ('Bolsa', 'bl'),
]


def grupo_admin_empresa():
    """Grupo con permisos sobre los datos de la empresa (no sobre usuarios ni otras empresas)."""
    grupo, _ = Group.objects.get_or_create(name=GRUPO_ADMIN_EMPRESA)
    grupo.permissions.set(Permission.objects.filter(content_type__app_label__in=APPS_DE_EMPRESA))
    return grupo


class Command(BaseCommand):
    help = 'Da de alta una empresa cliente con su usuario administrador.'

    def add_arguments(self, parser):
        parser.add_argument('nombre', help='Nombre del comercio')
        parser.add_argument('--usuario', required=True, help='Nombre de usuario del dueño')
        parser.add_argument('--password', help='Contraseña (si no se indica, se pide por teclado)')
        parser.add_argument('--email', default='')
        parser.add_argument('--ruc', default='')
        parser.add_argument('--telefono', default='')
        parser.add_argument('--plan', default='basico', choices=[c for c, _ in Empresa.PLAN_CHOICES])

    def handle(self, *args, **opts):
        if User.objects.filter(username=opts['usuario']).exists():
            raise CommandError(f"El usuario '{opts['usuario']}' ya existe.")

        password = opts['password'] or getpass('Contraseña del usuario: ')
        if not password:
            raise CommandError('La contraseña no puede estar vacía.')

        with transaction.atomic():
            empresa = Empresa.objects.create(
                nombre=opts['nombre'], ruc=opts['ruc'], telefono=opts['telefono'],
                email=opts['email'], plan=opts['plan'],
            )
            UnidadMedida.objects.bulk_create(
                UnidadMedida(empresa=empresa, nombre=n, abreviatura=a) for n, a in UNIDADES_INICIALES
            )
            user = User.objects.create_user(
                username=opts['usuario'], password=password, email=opts['email'], is_staff=True,
            )
            user.groups.add(grupo_admin_empresa())
            Perfil.objects.update_or_create(user=user, defaults={'empresa': empresa, 'cargo': 'Dueño'})

        self.stdout.write(self.style.SUCCESS(
            f"Empresa '{empresa.nombre}' creada (id {empresa.id}) con el usuario '{user.username}'."
        ))
