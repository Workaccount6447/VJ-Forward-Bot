FROM python:3.10-slim-bookworm

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# Copy and install requirements
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -r /app/requirements.txt

# Copy project
WORKDIR /app
COPY . .

# Expose port
EXPOSE 8000

# Start services
CMD ["bash", "-lc", "gunicorn app:app --workers 2 --threads 2 --bind 0.0.0.0:8000 & python3 main.py"]

