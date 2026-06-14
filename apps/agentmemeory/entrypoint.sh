#!/bin/sh
# agentmemory entrypoint. Three modes:
#   1. AGENTMEMORY_SECRET set in env (preferred, K8s Secret backed by Infisical)
#   2. First boot fallback: generate HMAC, store at /data/.hmac, print once to stdout
#   3. MCP shim (arg "mcp"): skip secret dance; AGENTMEMORY_SECRET + AGENTMEMORY_URL via env
set -eu

if [ "${1:-}" != "mcp" ] && [ -z "${AGENTMEMORY_SECRET:-}" ]; then
    HMAC_FILE="${AGENTMEMORY_HMAC_FILE:-/data/.hmac}"
    DATA_DIR="${AGENTMEMORY_DATA_DIR:-/data}"
    mkdir -p "${DATA_DIR}"
    if [ ! -s "${HMAC_FILE}" ]; then
      SECRET="$(openssl rand -hex 32)"
      umask 077
      printf '%s\n' "${SECRET}" > "${HMAC_FILE}"
      chmod 600 "${HMAC_FILE}"
      echo "================================================================"
      echo "agentmemory: generated HMAC secret on first boot"
      echo "AGENTMEMORY_SECRET=${SECRET}"
      echo "Copy now — not printed again. Stored at ${HMAC_FILE} (chmod 600)"
      echo "Rotate: delete ${HMAC_FILE} on PV and restart."
      echo "================================================================"
    fi
    AGENTMEMORY_SECRET="$(cat "${HMAC_FILE}")"
    export AGENTMEMORY_SECRET
fi

exec agentmemory "$@"
