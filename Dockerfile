FROM python:3.11-slim

# CIS 4.1: Crear grupo y usuario no privilegiado (appuser)
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

WORKDIR /app

# CIS 4.9: Usar la instrucción COPY en lugar de ADD para evitar riesgos remotos
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# CIS 4.9: Copiar los archivos locales de la aplicación
COPY . .

# CIS 4.1: Asignar propiedad de los archivos y establecer el usuario de ejecución
RUN chown -R appuser:appgroup /app
USER appuser

# CIS 4.6: Monitoreo periódico de salud del contenedor mediante la API interna
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

EXPOSE 5000

CMD ["python", "app.py"]