FROM python:3.11-slim

RUN apt-get update && apt-get install -y curl git build-essential \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app
RUN git clone https://github.com/AndreaBozzo/fantacalcio-py.git .
WORKDIR /app

RUN poetry install --no-interaction --no-ansi
RUN poetry install --no-interaction --no-ansi
COPY upload_to_github.py /app/upload_to_github.py
CMD poetry run python cli.py run && poetry run python upload_to_github.py
