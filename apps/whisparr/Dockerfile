FROM --platform=$BUILDPLATFORM ghcr.io/krezh/alpine:rolling@sha256:098becf3266ddfda0921bd866f964c2ed031e7fc81537dc1ede5d11c940b063f

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

ENV \
    WHISPARR__INSTANCE_NAME="Whisparr" \
    WHISPARR__BRANCH="${CHANNEL}" \
    WHISPARR__PORT="8989" \
    WHISPARR__ANALYTICS_ENABLED="False"

#hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates icu-libs libintl sqlite-libs xmlstarlet tar
#hadolint ignore=DL3059
RUN \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='x64' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && \
    mkdir -p /app/bin \
    && \ 
    curl -fsSL "https://whisparr.servarr.com/v1/update/nightly/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=${ARCH}" \ 
        | tar xzf - -C "/app/bin" --strip-components=1 \
    && \
    rm -rf \
        /app/bin/Whisparr.Update \
    && \
    printf "UpdateMethod=docker\nBranch=%s\nPackageVersion=%s\nPackageAuthor=[krezh](https://github.com/krezh)\n" "${WHISPARR__BRANCH}" "${VERSION}" > /app/package_info \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && rm -rf /tmp/*

USER kah

COPY ./config.xml.tmpl /app/config.xml.tmpl
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.title="${WHISPARR__INSTANCE_NAME} (${WHISPARR__BRANCH})"
