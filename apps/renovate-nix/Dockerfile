ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Install Nix using containerbase (like official renovate image does)
RUN containerbase-cli install tool nix ${NIX_VERSION}

# Configure Nix settings
RUN mkdir -p /etc/nix && \
    echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf && \
    echo "accept-flake-config = true" >> /etc/nix/nix.conf

USER ubuntu
