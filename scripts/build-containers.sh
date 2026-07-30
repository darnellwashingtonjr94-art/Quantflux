#!/bin/bash
# scripts/build-containers.sh

set -e
VERSION=${1:-"latest"}
REGISTRY="us-central1-docker.pkg.dev/quantflux/repo"

echo "Building containers for tag: $VERSION"

SERVICES=("api" "trading-engine" "risk-engine" "ai-engine")

for SERVICE in "${SERVICES[@]}"; do
    echo "Building $SERVICE..."
    docker build -t "$REGISTRY/$SERVICE:$VERSION" -f "infra/docker/$SERVICE.Dockerfile" .
done

echo "Container builds complete. Ready to push to registry."
