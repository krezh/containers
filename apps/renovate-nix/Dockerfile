ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Create directories for nix
RUN mkdir -p /nix /opt/nix && \
    chown -R ubuntu:ubuntu /nix /opt/nix

USER ubuntu

# Install Nix manually to /opt/nix to avoid containerbase conflicts
RUN curl -SsL "https://releases.nixos.org/nix/nix-${NIX_VERSION}/install" | sh -s -- --no-daemon && \
    mkdir -p /opt/nix/profile && \
    cp -a "$HOME/.local/state/nix/profiles/profile"/* /opt/nix/profile/ && \
    rm -rf "$HOME/.local/state/nix" "$HOME/.nix-profile" && \
    ln -s /opt/nix/profile "$HOME/.nix-profile"

USER root

# Put nix config in /etc/nix (system-wide, not affected by /tmp mount)
RUN mkdir -p /etc/nix && \
    { \
      echo "experimental-features = nix-command flakes"; \
      echo "accept-flake-config = true"; \
    } > /etc/nix/nix.conf

USER root

# Wrapper that injects RENOVATE_TOKEN into NIX_CONFIG per-invocation so GitHub
# API calls are authenticated; baked into the image so it works even when the
# operator runs renovate directly (bypassing ENTRYPOINT).
RUN mkdir -p /opt/nix/wrapper && \
    { \
      echo '#!/bin/sh'; \
      echo '[ -n "${RENOVATE_TOKEN:-}" ] && export NIX_CONFIG="access-tokens = github.com=$RENOVATE_TOKEN"'; \
      echo 'exec /opt/nix/profile/bin/nix "$@"'; \
    } > /opt/nix/wrapper/nix && \
    chmod +x /opt/nix/wrapper/nix

ENV PATH="/opt/nix/wrapper:/opt/nix/profile/bin:${PATH}"

COPY --chmod=755 entrypoint.sh /entrypoint.sh

USER ubuntu

ENTRYPOINT ["/entrypoint.sh"]
