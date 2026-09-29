FROM python:3.11-slim

# Crear usuario y grupo no privilegiado
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Asignar permisos al directorio del proyecto y cambiar al usuario no root
RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 5000

CMD ["python", "app.py"]