FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY zx303_backend.py .

# Expose ports
EXPOSE 8080 5001

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3   CMD curl -f http://localhost:8080/api/devices || exit 1

# Run app
CMD ["python", "zx303_backend.py"]
