ARG VERSION
FROM ghcr.io/opentofu/opentofu:1.6.0 as terraform

ARG CHANNEL
ARG VERSION
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETOS

FROM ghcr.io/weaveworks/tf-runner:v${VERSION} as runner

LABEL org.opencontainers.image.source="https://github.com/weaveworks/tf-controller"
LABEL krezh.image.target_platform=$TARGETPLATFORM
LABEL krezh.image.target_architecture=$TARGETARCH
LABEL krezh.image.target_os=$TARGETOS
LABEL org.opencontainers.image.source="https://github.com/TwiN/gatus"

USER root

COPY --from=terraform --chown=65532:65532 /usr/local/bin/tofu /usr/local/bin/terraform

USER 65532:65532