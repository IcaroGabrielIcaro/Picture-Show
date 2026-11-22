FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --only-binary=:all: -r requirements.txt

RUN useradd --create-home appuser

RUN mkdir -p /app/data /app/static /app/staticfiles /app/media \
    && chown -R appuser:appuser /app/data /app/static /app/staticfiles /app/media

COPY manage.py .
COPY picture_show/ picture_show/
COPY api/ api/

RUN chown -R root:root /app \
    && chmod -R a-w /app \
    && chmod -R a+rX /app \
    && chown -R appuser:appuser /app/data /app/static /app/staticfiles /app/media

USER appuser

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && exec gunicorn picture_show.wsgi:application --bind 0.0.0.0:8000 --workers 3"]