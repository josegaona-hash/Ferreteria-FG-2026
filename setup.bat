@echo off
echo ============================================
echo   Ferreteria FG - Instalacion en Windows
echo ============================================

python -m venv venv
call venv\Scripts\activate

pip install -r requirements.txt

copy .env.example .env
echo.
echo Edita el archivo .env si necesitas cambiar la base de datos
echo.

python manage.py migrate
python manage.py collectstatic --noinput

echo.
echo Creando superusuario...
python manage.py createsuperuser

echo.
echo ============================================
echo   Instalacion completada!
echo   Ejecuta: python manage.py runserver
echo   Accede:  http://localhost:8000
echo ============================================
pause
