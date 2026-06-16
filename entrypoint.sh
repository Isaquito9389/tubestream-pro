#!/bin/bash

# Définir le PORT par défaut à 5000 s'il n'est pas défini
PORT=${PORT:-5000}

# Lancer gunicorn avec le PORT correctement résolu
exec gunicorn app:app \
    --bind 0.0.0.0:$PORT \
    --timeout 300 \
    --workers 4 \
    --threads 2 \
    --keep-alive 120 \
    --access-logfile - \
    --error-logfile -
