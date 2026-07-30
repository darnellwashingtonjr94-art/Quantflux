#!/bin/bash
# scripts/stream-logs.sh

set -e
SERVICE=${1:-"all"}

echo "Streaming logs for $SERVICE..."

if [ "$SERVICE" == "all" ]; then
    docker-compose -f infra/docker/docker-compose.yml logs -f --tail=100
else
    docker-compose -f infra/docker/docker-compose.yml logs -f --tail=100 "$SERVICE"
fi
