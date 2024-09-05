ARG VERSION
FROM ghcr.io/opentofu/opentofu:1.8.2 as tofu
ARG VERSION

FROM ghcr.io/flux-iac/tf-runner:v${VERSION}
ARG TARGETPLATFORM
ARG CHANNEL
ARG TARGETARCH
ARG TARGETOS
ARG VERSION

LABEL org.opencontainers.image.target_platform=${TARGETPLATFORM}
LABEL org.opencontainers.image.target_architecture=${TARGETARCH}
LABEL org.opencontainers.image.target_os=${TARGETOS}
LABEL org.opencontainers.image.channel=${CHANNEL}
LABEL org.opencontainers.image.runner_version=${VERSION}
LABEL org.opencontainers.image.source="https://github.com/weaveworks/tf-controller"

USER root

COPY --from=tofu --chown=65532:65532 /usr/local/bin/tofu /usr/local/bin/terraform

USER 65532:65532