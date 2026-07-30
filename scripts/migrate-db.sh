#!/bin/bash
# scripts/migrate-db.sh

set -e
ENV=${1:-"local"}

echo "Applying database migrations for $ENV environment..."
source .venv/bin/activate

cd libs/db
alembic upgrade head
cd ../../

echo "Migrations successfully applied."
