FROM python:3.11-slim-bookworm

WORKDIR /app

# 1. Copia solo requirements.txt per sfruttare la cache di Docker:
# pip installerà di nuovo i pacchetti solo se modifichi questo file
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 2. Copia tutto il resto del codice del repository nella cartella /app
COPY . .

EXPOSE 7860

CMD ["uvicorn", "run:main_app", "--host", "0.0.0.0", "--port", "7860", "--workers", "4"]
