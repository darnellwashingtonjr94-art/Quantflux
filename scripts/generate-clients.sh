#!/bin/bash
# scripts/generate-clients.sh

set -e
echo "Generating OpenAPI spec from FastAPI..."

curl -s http://localhost:8000/openapi.json > docs/api/openapi.json

echo "Generating TypeScript client for Next.js..."
npx openapi-typescript docs/api/openapi.json -o apps/web/lib/api/schema.d.ts

echo "Client generation complete."
