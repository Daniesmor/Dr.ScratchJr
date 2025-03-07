FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN python manage.py makemigrations
RUN python manage.py migrate --run-syncdb

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

