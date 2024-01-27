ARG VERSION
FROM ghcr.io/krezh/alpine:rolling@sha256:5038dad72effc3fd27b56cadfd129646158c67f9568856b4eca1e15a898140a2
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

LABEL org.opencontainers.image.source="https://codeberg.org/readeck/readeck"

ENV READECK_SERVER_HOST=0.0.0.0
ENV READECK_SERVER_PORT=8080
ENV READECK_USE_X_FORWARDED=true

# Download source
RUN \
    curl -fsSLo /app/readeck "https://codeberg.org/readeck/readeck/releases/download/${VERSION}/readeck-${VERSION}-linux-amd64" \
    && \
    chown -R root:root /app \
    && chmod -R 755 /app \
    && chmod +x /app/readeck \
    && rm -rf /tmp/*

# Install
RUN \
    apk add --no-cache \
        ca-certificates \
    && rm -rf \
        /root/.cache \
        /tmp/*

USER kah
COPY ./entrypoint.sh /entrypoint.sh

VOLUME /config
WORKDIR /config

CMD ["/entrypoint.sh"]
