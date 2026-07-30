#!/bin/bash
# scripts/start-workers.sh

set -e
echo "Booting Celery workers for async task orchestration..."
source .venv/bin/activate

# Start the main worker pool
celery -A apps.worker.celery_app worker --loglevel=info --concurrency=4 &

# Start the Celery beat scheduler for recurring cron tasks (e.g., daily PnL)
celery -A apps.worker.celery_app beat --loglevel=info &

wait
