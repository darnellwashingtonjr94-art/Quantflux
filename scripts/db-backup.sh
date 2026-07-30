#!/bin/bash
# scripts/db-backup.sh

set -e
ENV=${1:-"local"}
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="data/backups"

mkdir -p "$BACKUP_DIR"
FILE_PATH="$BACKUP_DIR/db_dump_$ENV_$TIMESTAMP.sql"

echo "Initiating database backup for $ENV environment..."

if [ "$ENV" == "local" ]; then
    docker exec -t quantflux-db pg_dump -U postgres -d quantflux > "$FILE_PATH"
else
    # Assumes PG_URI is set in the production environment
    pg_dump "$PG_URI" > "$FILE_PATH"
fi

echo "Backup successfully saved to $FILE_PATH"
