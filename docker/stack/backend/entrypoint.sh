#!/bin/sh
set -e

# Apply migrations
migrate -path db/migration -database "$POSTGRES_URL?sslmode=disable" -verbose up

exec "$@"
