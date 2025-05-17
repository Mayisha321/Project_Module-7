# Use Python 3.12 slim base image
FROM python:3.12-slim

# Set working directory in container
WORKDIR /home/ubuntu/Project_Module-7/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Collect static files (optional if your app uses them)
#RUN python manage.py collectstatic --noinput

# Expose the port your app runs on
EXPOSE 8000

# Start Django Server : Run Gunicorn (adjust `projectname.wsgi` to match your Django project)
CMD ["gunicorn", "rapid.wsgi:application", "--bind", "0.0.0.0:8000"]


