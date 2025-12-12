FROM python:3.10-slim-buster

# Install system dependencies
RUN apt-get update -y --allow-releaseinfo-change && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first (layer caching)
COPY requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r /app/requirements.txt

# Copy the whole project
WORKDIR /app
COPY . .

# Expose Koyeb port
EXPOSE 8080

# Start Gunicorn + main.py
CMD ["bash", "-c", "gunicorn app:app --bind 0.0.0.0:8080 & python3 main.py"]
