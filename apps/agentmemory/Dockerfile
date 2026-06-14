# syntax=docker/dockerfile:1
FROM docker.io/library/node:24-slim
ARG TARGETARCH
ARG VERSION
ARG III_VERSION=0.11.2
ARG WITH_LOCAL_EMBEDDINGS=false

ENV \
    AGENTMEMORY_DATA_DIR=/data \
    AGENTMEMORY_HMAC_FILE=/data/.hmac \
    AGENTMEMORY_VIEWER_HOST=0.0.0.0 \
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
    && AMM="/usr/local/lib/node_modules/@agentmemory/agentmemory/node_modules" \
    && if [ "${WITH_LOCAL_EMBEDDINGS}" != "true" ]; then \
         rm -rf \
             "${AMM}/onnxruntime-node" \
             "${AMM}/onnxruntime-web" \
             "${AMM}/onnxruntime-common" \
             "${AMM}/onnx-proto" \
             "${AMM}/@xenova" \
             "${AMM}/sharp" \
             "${AMM}/@node-rs" \
             "${AMM}/tiny-segmenter"; \
       fi \
    && mkdir -p /data \
    && chown -R node:node /data /app \
    && apt-get purge -y --auto-remove curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /root/.npm \
        /usr/local/lib/node_modules/npm \
        /usr/local/lib/node_modules/corepack \
        /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack

ENV AGENTMEMORY_III_CONFIG=/usr/local/lib/node_modules/@agentmemory/agentmemory/iii-config.docker.yaml

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

LABEL org.opencontainers.image.source="https://github.com/rohitg00/agentmemory" \
      org.opencontainers.image.title="agentmemory" \
      org.opencontainers.image.description="Persistent memory for AI coding agents (REST + MCP shim)"

USER node:node
WORKDIR /data
EXPOSE 3111 3112 3113
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
