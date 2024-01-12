ARG TARGETPLATFORM

FROM --platform=$TARGETPLATFORM ghcr.io/opentofu/opentofu:1.6.0 as tofu

ARG VERSION
ARG TARGETPLATFORM

FROM --platform=$TARGETPLATFORM ghcr.io/weaveworks/tf-runner:v${VERSION}

ARG TARGETPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG TARGETOS

LABEL org.opencontainers.image.target_platform="$TARGETPLATFORM"
LABEL org.opencontainers.image.target_architecture="$TARGETARCH"
LABEL org.opencontainers.image.target_os="$TARGETOS"
LABEL org.opencontainers.image.channel="$CHANNEL"
LABEL org.opencontainers.image.source="https://github.com/weaveworks/tf-controller"

USER root

COPY --from=tofu --chown=65532:65532 /usr/local/bin/tofu /usr/local/bin/terraform

USER 65532:65532