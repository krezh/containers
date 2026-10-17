# syntax=docker/dockerfile:1
FROM docker.io/library/alpine:3.22

ARG TARGETARCH
ARG VENDOR=krezh
ARG VERSION

ENV UMASK="0002" \
    TZ="Etc/UTC"

RUN apk add --no-cache \
        bash \
        ca-certificates \
        catatonit \
        curl \
        gettext-envsubst \
        icu-libs \
        libstdc++ \
        sqlite-libs \
        tzdata \
        xmlstarlet \
    && case "${TARGETARCH}" in \
        amd64) ARCH="x64" ;; \
        arm64) ARCH="arm64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && mkdir -p /app/bin /config \
    && curl -fsSL "https://github.com/Whisparr/Whisparr-Eros/releases/download/v${VERSION}/Whisparr.eros.${VERSION}.linux-musl-${ARCH}.tar.gz" \
        | tar xzf - -C /app/bin --strip-components=1 \
    && printf "UpdateMethod=docker\nBranch=eros\nPackageVersion=%s\nPackageAuthor=[%s](https://github.com/%s)\n" "${VERSION}" "${VENDOR}" "${VENDOR}" > /app/package_info \
    && rm -rf /app/bin/Whisparr.Update \
    && chown -R root:root /app \
    && chmod -R a=rX /app \
    && chmod 755 /app/bin/Whisparr /app/bin/ffprobe \
    && chown nobody:nogroup /config

COPY --chmod=755 entrypoint.sh /entrypoint.sh
COPY config.xml.tmpl /app/config.xml.tmpl

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]
EXPOSE 8989

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
