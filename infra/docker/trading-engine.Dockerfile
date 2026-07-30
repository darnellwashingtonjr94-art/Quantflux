# infra/docker/trading-engine.Dockerfile
FROM python:3.11-slim

WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install heavy compilation dependencies (gcc, g++, python-dev)
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install base quant requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy monorepo structure
COPY ./libs /app/libs
COPY ./apps/trading-engine /app/apps/trading-engine

# Pre-compile obfuscated strategies if they exist
RUN python -c "import compileall; compileall.compile_dir('/app/apps/trading-engine/strategies')"

CMD ["python", "-m", "apps.trading-engine.main"]
