import gzip
from pathlib import Path

from django.conf import settings
from django.core.management import call_command
from django.core.management.base import BaseCommand
from django.utils import timezone

EXCLUIR = ['contenttypes', 'auth.permission', 'sessions', 'admin.logentry']


class Command(BaseCommand):
    help = (
        'Guarda una copia de seguridad comprimida de toda la base de datos. '
        'Se restaura con: python manage.py loaddata <archivo>.json.gz'
    )

    def add_arguments(self, parser):
        parser.add_argument('--salida', default=str(settings.BASE_DIR / 'respaldos'),
                            help='Carpeta donde guardar los respaldos')
        parser.add_argument('--conservar', type=int, default=14,
                            help='Cantidad de respaldos a conservar (los más antiguos se borran)')

    def handle(self, *args, **opts):
        carpeta = Path(opts['salida'])
        carpeta.mkdir(parents=True, exist_ok=True)
        archivo = carpeta / f"respaldo-{timezone.localtime():%Y%m%d-%H%M%S}.json.gz"

        with gzip.open(archivo, 'wt', encoding='utf-8') as f:
            call_command('dumpdata', exclude=EXCLUIR, natural_foreign=True, natural_primary=True,
                         indent=None, stdout=f)
        self.stdout.write(self.style.SUCCESS(f'Respaldo guardado en {archivo}'))

        respaldos = sorted(carpeta.glob('respaldo-*.json.gz'))
        for viejo in respaldos[:-opts['conservar']] if opts['conservar'] > 0 else []:
            viejo.unlink()
            self.stdout.write(f'Borrado respaldo antiguo: {viejo.name}')
