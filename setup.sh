#!/bin/bash
echo "============================================"
echo "  Ferreteria FG - Instalacion Linux/Mac"
echo "============================================"

python3 -m venv venv
source venv/bin/activate

pip install -r requirements.txt

cp .env.example .env
echo "Edita .env si necesitas cambiar la base de datos"

python manage.py migrate
python manage.py collectstatic --noinput

echo "Creando superusuario..."
python manage.py createsuperuser

echo "============================================"
echo "  Listo! Ejecuta: python manage.py runserver"
echo "  Accede: http://localhost:8000"
echo "============================================"
