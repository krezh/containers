FROM ghcr.io/krezh/alpine:rolling@sha256:9b0cc3e1aa40f69016cc1536dc39320994b10718e86cced8b1a19784241e7281
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
