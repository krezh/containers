ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Create /nix directory with proper permissions
RUN mkdir -p /nix && chown -R ubuntu:ubuntu /nix

USER ubuntu

# Install Nix manually to get /nix/store (for binary cache)
RUN curl -SsL "https://releases.nixos.org/nix/nix-${NIX_VERSION}/install" | sh -s -- --no-daemon && \
    mkdir -p "$HOME/.config/nix" && \
    { \
      echo "experimental-features = nix-command flakes"; \
      echo "accept-flake-config = true"; \
    } > "$HOME/.config/nix/nix.conf"

USER root

# Add nix to PATH in env.d (for entrypoint)
RUN mkdir -p /usr/local/env.d && \
    { \
      echo '#!/bin/bash'; \
      echo 'export PATH="/home/ubuntu/.nix-profile/bin:${PATH}"'; \
    } > /usr/local/env.d/90-nix.sh && \
    chmod +x /usr/local/env.d/90-nix.sh

# Set PATH as ENV so it's available to all processes
ENV PATH="/home/ubuntu/.nix-profile/bin:${PATH}"

USER ubuntu
