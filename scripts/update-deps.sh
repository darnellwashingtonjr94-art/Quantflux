#!/bin/bash
# scripts/update-deps.sh

set -e
echo "Updating monorepo dependencies..."

echo "Updating Node.js packages..."
cd apps/web && npm update && cd ../../

echo "Updating Python packages..."
source .venv/bin/activate
pip install --upgrade -r requirements.txt

echo "Running test suite to verify compatibility..."
./scripts/run-tests.sh

echo "Dependencies updated and validated."
