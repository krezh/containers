FROM ghcr.io/opentofu/opentofu:1.6.0 as terraform

ARG CHANNEL
ARG TARGETPLATFORM
ARG VERSION

FROM ghcr.io/weaveworks/tf-runner:v${VERSION} as runner

LABEL org.opencontainers.image.source="https://github.com/weaveworks/tf-controller"

USER root

COPY --from=terraform --chown=65532:65532 /usr/local/bin/tofu /usr/local/bin/terraform

USER 65532:65532