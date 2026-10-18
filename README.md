# Ferreteria FG - Sistema de Gestion

Sistema de gestion completo para ferreteria, construido con Django 5.2 y Python 3.12.

## Modulos incluidos
- Dashboard con estadisticas en tiempo real
- Punto de Venta (POS) con busqueda por nombre y codigo de barras
- Historial de ventas
- Inventario de productos con control de stock
- Gestion de clientes
- Gestion de proveedores
- Compras a proveedores
- Control de caja (ingresos y egresos)
- Reportes de ventas e inventario
- Panel de administracion Django
- Multiempresa: varios comercios en una sola instalacion, cada uno ve solo sus datos

## Instalacion rapida

### Windows
```
setup.bat
```

### Linux / Mac
```
bash setup.sh
```

### Manual
```bash
python -m venv venv
source venv/bin/activate   # Windows: venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

## Multiempresa (venta por suscripcion)

Cada usuario pertenece a una empresa (Admin > Usuarios > Perfil). Todas las pantallas,
el punto de venta, los reportes y el panel admin muestran solo los datos de esa empresa.
El superusuario (el dueño del sistema) ve todas las empresas desde el panel admin.

Dar de alta un comercio nuevo con su usuario administrador:
```bash
python manage.py crear_empresa "Ferreteria Lopez" --usuario lopez --email lopez@correo.com --plan comercio
```
Esto crea la empresa, unidades de medida iniciales y un usuario con acceso al panel admin
limitado a su empresa.

Para suspender un cliente (por ejemplo, por falta de pago) desmarcar **Activa** en
Admin > Empresas. Sus usuarios pierden el acceso, pero los datos se conservan.

Las instalaciones anteriores pasan automaticamente sus datos y usuarios a una empresa
"Ferreteria FG" al ejecutar `python manage.py migrate`.

## Base de datos

Sin configuracion se usa SQLite (`db.sqlite3`). Para PostgreSQL definir en `.env`:
```
DATABASE_URL=postgres://usuario:clave@localhost:5432/ferreteria
```

## Copias de seguridad

```bash
python manage.py respaldar                 # guarda respaldos/respaldo-AAAAMMDD-HHMMSS.json.gz
python manage.py respaldar --conservar 30  # conserva los ultimos 30
python manage.py loaddata respaldos/respaldo-....json.gz   # restaurar en una base vacia
```
Conviene programarlo una vez por dia (cron del servidor o tarea programada de Windows).

## Publicar en internet

### Render
1. Subir el repositorio a GitHub.
2. En https://render.com: **New > Blueprint** y elegir el repositorio. `render.yaml`
   crea el servidor web y la base PostgreSQL, y genera la `SECRET_KEY`.
3. Crear el superusuario desde la consola del servicio: `python manage.py createsuperuser`.

### Railway u otros
Usar el `Procfile` y definir las variables de entorno:
`DEBUG=False`, `SECRET_KEY`, `DATABASE_URL`, `ALLOWED_HOSTS` (tu dominio) y
`CSRF_TRUSTED_ORIGINS` (por ejemplo `https://tu-dominio.com`). El comando de
instalacion es `./build.sh`.

Nota: en estos servicios el disco se borra en cada despliegue, por eso las imagenes
de productos subidas se pierden. Para produccion conviene guardarlas en un
almacenamiento externo (S3, Cloudinary, etc.).

## Pruebas

```bash
python manage.py test
```

## Acceso
- Sistema: http://localhost:8000
- Admin:   http://localhost:8000/admin

## Tecnologias
- Python 3.12
- Django 5.2
- Django REST Framework
- SQLite (desarrollo) / PostgreSQL (produccion)
- Gunicorn + WhiteNoise (produccion)
- Font Awesome 6
- Google Fonts (Poppins)

## Configuracion .env
```
SECRET_KEY=tu-clave-secreta
DEBUG=True
DB_ENGINE=django.db.backends.sqlite3
DB_NAME=db.sqlite3
```

## Para usar PostgreSQL
```
DB_ENGINE=django.db.backends.postgresql
DB_NAME=ferreteria_fg
DB_USER=postgres
DB_PASSWORD=tu-contrasena
DB_HOST=localhost
DB_PORT=5432
```
