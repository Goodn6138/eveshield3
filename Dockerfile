FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY zx303_backend.py .

EXPOSE 8080 5001

CMD ["python", "zx303_backend.py"]
