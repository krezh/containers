FROM --platform=$BUILDPLATFORM ghcr.io/krezh/alpine:rolling@sha256:5038dad72effc3fd27b56cadfd129646158c67f9568856b4eca1e15a898140a2

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
