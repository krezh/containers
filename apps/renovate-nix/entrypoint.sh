#!/usr/bin/env sh
set -e

# Install a wrapper so every nix invocation picks up RENOVATE_TOKEN from the
# subprocess environment (Renovate injects it when running postUpgradeTasks,
# which may be after the container starts with no token yet mounted).
_nix_real="$(command -v nix 2>/dev/null || true)"
if [ -n "$_nix_real" ]; then
    _wrapper_dir="$HOME/.local/bin"
    mkdir -p "$_wrapper_dir"
    # $RENOVATE_TOKEN must expand at wrapper runtime, not here
    # shellcheck disable=SC2016
    printf '#!/bin/sh\n[ -n "${RENOVATE_TOKEN:-}" ] && export NIX_CONFIG="access-tokens = github.com=$RENOVATE_TOKEN"\nexec "%s" "$@"\n' \
        "$_nix_real" > "$_wrapper_dir/nix"
    chmod +x "$_wrapper_dir/nix"
    export PATH="$_wrapper_dir:$PATH"
    echo "[entrypoint] nix wrapper installed: token=${RENOVATE_TOKEN:+PRESENT}${RENOVATE_TOKEN:-ABSENT}"
fi

exec "$@"
