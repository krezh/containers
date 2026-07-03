#!/usr/bin/env sh
set -e
/opt/nix/write-nix-auth.sh
exec "$@"
