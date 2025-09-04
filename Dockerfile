FROM python:3.11-slim

# Install necessary packages and Poetry
RUN apt-get update && apt-get install -y curl git build-essential \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && rm -rf /var/lib/apt/lists/*

RUN pip install requests

ENV PATH="/root/.local/bin:$PATH"

# Remove any existing app directory
RUN rm -rf /app

# Clone the repository into /app
RUN git clone https://github.com/AndreaBozzo/fantacalcio-py.git /app

COPY . /app
WORKDIR /app

# Install dependencies with Poetry
RUN poetry install --no-interaction --no-ansi

# Run the desired commands
#CMD bash -c "poetry run python cli.py run --source fpedia --force-scrape && python publish_release.py"
CMD bash -c "poetry run python cli.py run --source fpedia && python publish_release.py"
