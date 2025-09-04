FROM python:3.11-slim

RUN apt-get update && apt-get install -y curl git build-essential \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.local/bin:$PATH"

RUN rm -r -f app
RUN git clone https://github.com/AndreaBozzo/fantacalcio-py.git app
RUN cd app
RUN ls
RUN poetry install --no-interaction --no-ansi
CMD poetry run python cli.py run && poetry run python publish_release.py
