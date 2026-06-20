#!/usr/bin/env sh
set -e

if [ -n "$RENOVATE_TOKEN" ]; then
    export NIX_CONFIG="access-tokens = github.com=$RENOVATE_TOKEN"
fi

exec "$@"
