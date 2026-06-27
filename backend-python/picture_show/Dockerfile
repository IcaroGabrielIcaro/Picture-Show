FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/data
RUN mkdir -p /app/static
RUN mkdir -p /app/staticfiles
RUN mkdir -p /app/media

EXPOSE 8000

CMD ["sh", "-c", "\
python manage.py makemigrations && \
python manage.py migrate && \
python manage.py collectstatic --noinput && \
gunicorn picture_show.wsgi:application --bind 0.0.0.0:8000 --workers 3"]