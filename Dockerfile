FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt Makefile ./
RUN make install
COPY app.py .
COPY tests ./tests
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]