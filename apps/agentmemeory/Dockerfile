# syntax=docker/dockerfile:1
FROM docker.io/library/node:24-slim
ARG TARGETARCH
ARG VERSION
ARG III_VERSION=0.11.2

ENV \
    AGENTMEMORY_DATA_DIR=/data \
    AGENTMEMORY_HMAC_FILE=/data/.hmac \
    III_REST_PORT=3111 \
    NODE_ENV=production

USER root
WORKDIR /app

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        catatonit \
        curl \
        openssl \
        tzdata \
    && case "${TARGETARCH}" in \
         amd64) iii_target="x86_64-unknown-linux-gnu" ;; \
         arm64) iii_target="aarch64-unknown-linux-gnu" ;; \
         *) echo "unsupported arch ${TARGETARCH}"; exit 1 ;; \
       esac \
    && curl -fsSL "https://github.com/iii-hq/iii/releases/download/iii%2Fv${III_VERSION}/iii-${iii_target}.tar.gz" \
        | tar -xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/iii \
    && iii --version \
    && npm install -g --omit=optional --no-fund --no-audit \
        "@agentmemory/agentmemory@${VERSION}" \
        @xenova/transformers \
    && find /usr/local/lib/node_modules/@agentmemory/agentmemory \
        -name 'iii-config.yaml' -print0 \
        | xargs -0 -r sed -i 's/host: 127\.0\.0\.1/host: 0.0.0.0/g' \
    && find /usr/local/lib/node_modules/@agentmemory/agentmemory \
        -type f \( -name '*.js' -o -name '*.mjs' -o -name '*.cjs' \) -print0 \
        | xargs -0 -r sed -i -E 's/\.listen\(([a-zA-Z_][a-zA-Z0-9_]*), "127\.0\.0\.1"/.listen(\1, "0.0.0.0"/g' \
    && mkdir -p /data \
    && chown -R node:node /data /app \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /root/.npm

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

LABEL org.opencontainers.image.source="https://github.com/rohitg00/agentmemory" \
      org.opencontainers.image.title="agentmemory" \
      org.opencontainers.image.description="Persistent memory for AI coding agents (REST + MCP shim)"

USER node:node
WORKDIR /data
EXPOSE 3111
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
