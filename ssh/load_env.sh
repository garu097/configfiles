#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ ENV file not found: $ENV_FILE"
  exit 1
fi

echo "🔧 Loading env from $ENV_FILE"

set -a
source "$ENV_FILE"
set +a

exec "$@"