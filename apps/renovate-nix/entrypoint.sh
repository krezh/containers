#!/usr/bin/env sh
set -e

if [ -n "$RENOVATE_TOKEN" ]; then
    mkdir -p "$HOME/.config/nix"
    printf 'access-tokens = github.com=%s\n' "$RENOVATE_TOKEN" > "$HOME/.config/nix/nix.conf"
fi

exec "$@"
