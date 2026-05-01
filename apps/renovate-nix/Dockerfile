ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Create /nix directory with correct permissions
RUN mkdir -p /nix && chown -R ubuntu:ubuntu /nix

USER ubuntu

# Install Nix in single-user mode during build
RUN curl -SsL "https://releases.nixos.org/nix/nix-${NIX_VERSION}/install" | sh -s -- --no-daemon && \
    mkdir -p "$HOME/.config/nix" && \
    echo "experimental-features = nix-command flakes" > "$HOME/.config/nix/nix.conf" && \
    echo "accept-flake-config = true" >> "$HOME/.config/nix/nix.conf"

USER root

# Add Nix to PATH via containerbase env.d so it persists through entrypoint
RUN mkdir -p /usr/local/env.d && \
    echo 'export PATH="/home/ubuntu/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"' > /usr/local/env.d/nix.sh && \
    chmod +x /usr/local/env.d/nix.sh

USER ubuntu

ENV PATH="/usr/local/bin:/home/ubuntu/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"
