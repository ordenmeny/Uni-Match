FROM python:3.12-bookworm

WORKDIR /app

ENV PYTHONUNBUFFERED=1

EXPOSE 8000

COPY . .

ENV PATH="/django_venv/bin:$PATH"

RUN python -m venv /django_venv && \
    apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y libpq-dev && \
    apt-get install -y build-essential && \
    pip install "psycopg[c]" && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r req.txt && \
    mkdir -p /vol/web


CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
