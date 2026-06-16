# Image légère
FROM python:3.11-slim

# Empêche les logs bufferisés (important pour Railway)
ENV PYTHONUNBUFFERED=1

# Installer ffmpeg + dépendances
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Dossier de travail
WORKDIR /app

# Installer dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le projet
COPY . .

# Port par défaut (fallback)
ENV PORT=5000

# Exposer (optionnel mais propre)
EXPOSE 5000

# Commande robuste
CMD ["sh", "-c", "echo '🚀 Starting on PORT='$PORT && gunicorn app:app --bind 0.0.0.0:${PORT:-5000} --workers 2 --threads 2 --timeout 300"]
