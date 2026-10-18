#!/usr/bin/env bash
# Pasos de instalación en el servidor (Render, Railway u otro)
set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --noinput
python manage.py migrate --noinput
