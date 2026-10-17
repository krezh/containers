# syntax=docker/dockerfile:1
FROM docker.io/library/alpine:3.22

ARG TARGETARCH
ARG VERSION

ENV TZ="Etc/UTC" \
    HOME="/config" \
    USER="stash" \
    STASH_CONFIG_FILE="/config/config.yml"

RUN apk add --no-cache \
        ca-certificates \
        catatonit \
        curl \
        ffmpeg \
        py3-lxml \
        py3-pip \
        py3-requests \
        py3-requests-toolbelt \
        python3 \
        tzdata \
        vips-heif \
        vips-tools \
    && pip install --no-cache-dir --break-system-packages --root-user-action=ignore \
        cloudscraper \
        mechanicalsoup \
        stashapp-tools \
    && case "${TARGETARCH}" in \
        amd64) ARCH="linux" ;; \
        arm64) ARCH="linux-arm64v8" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && mkdir -p /app/bin /config \
    && curl -fsSL -o /app/bin/stash "https://github.com/stashapp/stash/releases/download/${VERSION}/stash-${ARCH}" \
    && chown -R root:root /app \
    && chmod -R a=rX /app \
    && chmod 755 /app/bin/stash \
    && chown nobody:nogroup /config

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]
EXPOSE 9999

ENTRYPOINT ["/usr/bin/catatonit", "--", "/app/bin/stash"]
