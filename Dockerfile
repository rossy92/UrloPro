FROM python:3.11-slim-bookworm

WORKDIR /app

# 1. Installa Tor dentro il server di Render
RUN apt-get update && apt-get install -y --no-install-recommends -o Acquire::Retries=3 tor && rm -rf /var/lib/apt/lists/*

# 2. Installa le librerie Python
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 3. Copia il codice del progetto
COPY . .

EXPOSE 7860

# 4. Avvia Tor in sottofondo (porta HTTP 8118) e poi avvia il server Python
CMD ["sh", "-c", "tor --RunAsDaemon 1 --HTTPTunnelPort 8118 && uvicorn run:main_app --host 0.0.0.0 --port 7860 --workers 1"]
