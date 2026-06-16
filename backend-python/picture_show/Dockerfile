FROM python:3.10

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/data
RUN mkdir -p /app/static

EXPOSE 8000

CMD ["sh", "-c", "python manage.py migrate && gunicorn picture_show.wsgi:application --bind 0.0.0.0:8000 --workers 3"]