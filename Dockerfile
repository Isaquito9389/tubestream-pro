FROM python:3.11-slim

# Install system dependencies + ffmpeg for audio extraction
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create required directories
RUN mkdir -p templates downloads static

# Expose port (Railway injecte PORT au runtime)
EXPOSE 5000

# Utiliser entrypoint pour résoudre $PORT correctement
ENTRYPOINT ["/entrypoint.sh"]
