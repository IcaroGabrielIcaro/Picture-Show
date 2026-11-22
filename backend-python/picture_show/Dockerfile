FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --only-binary=:all: -r requirements.txt

RUN useradd --create-home appuser

RUN mkdir -p /app/data /app/static /app/staticfiles /app/media \
    && chown -R appuser:appuser /app

COPY --chown=appuser:appuser manage.py .
COPY --chown=appuser:appuser picture_show/ picture_show/
COPY --chown=appuser:appuser api/ api/

USER appuser

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && exec gunicorn picture_show.wsgi:application --bind 0.0.0.0:8000 --workers 3"]