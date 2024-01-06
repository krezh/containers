FROM ghcr.io/krezh/alpine:rolling@sha256:e0cc091650a9b836f0521016941d567c3a0377e894a7bb8d4b4a79c1d788fcb6
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

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
COPY ./apps/readeck/entrypoint.sh /entrypoint.sh

VOLUME /config
WORKDIR /config

CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://codeberg.org/readeck/readeck"
