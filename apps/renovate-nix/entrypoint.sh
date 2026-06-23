#!/usr/bin/env sh
set -e
echo "[entrypoint] token=${RENOVATE_TOKEN:+PRESENT}${RENOVATE_TOKEN:-ABSENT}"
exec "$@"
