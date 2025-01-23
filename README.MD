services:
  app:
    build:
      context: djangoProject
    ports:
      - "8000:8000"
    volumes:
      - ./djangoProject:/app
      - ./data/web:/vol/web
    depends_on:
      db:
        condition: service_healthy
    env_file:
      - .env
    environment:
      - DB_HOST=${DB_HOST}
      - DB_NAME=${DB_NAME}
      - DB_USER=${DB_USER}
      - DB_PASS=${DB_PASS}
      - DEBUG=${DEBUG}
      - SECRET_KEY=${SECRET_KEY}

  db:
    image: postgres
    env_file:
      - .env
    environment:
      - POSTGRES_DB=${DB_NAME}
      - POSTGRES_USER=${DB_USER}
      - POSTGRES_PASSWORD=${DB_PASS}
    ports:
      - "5432:5432"
    volumes:
      - db-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-q", "-d", "devdb", "-U", "devuser"]
      interval: 5s
      timeout: 5s
      retries: 5


volumes:
  db-data:



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

