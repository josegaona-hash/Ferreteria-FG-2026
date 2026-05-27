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

## Acceso
- Sistema: http://localhost:8000
- Admin:   http://localhost:8000/admin

## Tecnologias
- Python 3.12
- Django 5.2
- Django REST Framework
- SQLite (desarrollo) / PostgreSQL (produccion)
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
