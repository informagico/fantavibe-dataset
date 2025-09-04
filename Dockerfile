FROM python:3.11-slim

# Installa dipendenze di sistema
RUN apt-get update && apt-get install -y curl git build-essential \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

# Imposta Poetry nel PATH
ENV PATH="/root/.local/bin:$PATH"

# Clona il repo
WORKDIR /app
RUN git clone https://github.com/AndreaBozzo/fantacalcio-py.git .
WORKDIR /app

# Installa dipendenze
RUN poetry install --no-interaction --no-ansi

# Comando di avvio
CMD ["poetry", "run", "python", "cli.py", "run"]
