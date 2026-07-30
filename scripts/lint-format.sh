#!/bin/bash
# scripts/lint-format.sh

set -e
echo "Formatting Python engines with Black and Ruff..."
source .venv/bin/activate
black apps/ libs/ scripts/
ruff check apps/ libs/ scripts/ --fix

echo "Formatting Next.js frontend with Prettier and ESLint..."
cd apps/web
npx prettier --write .
npx eslint . --fix
cd ../../

echo "Linting complete. Code is clean."
