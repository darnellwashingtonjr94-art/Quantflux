#!/bin/bash
# scripts/start-dev.sh

set -e
echo "Spinning up local infrastructure (Postgres, Redis, Kafka)..."
docker-compose -f infra/docker/docker-compose.yml up -d db redis kafka

echo "Starting FastAPI gateway..."
source .venv/bin/activate
uvicorn apps.api.main:app --reload --host 0.0.0.0 --port 8000 &

echo "Starting Next.js frontend..."
cd apps/web && npm run dev &

echo "Development environment running. Press Ctrl+C to terminate."
wait
