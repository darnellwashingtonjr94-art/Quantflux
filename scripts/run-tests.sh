#!/bin/bash
# scripts/run-tests.sh

set -e
echo "Running Python unit and integration tests (pytest)..."
source .venv/bin/activate
pytest apps/ libs/ --cov --cov-report=term-missing

echo "Running Next.js and frontend tests (Jest)..."
cd apps/web
npm run test
cd ../../

echo "All test suites passed successfully."
