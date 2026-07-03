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

# Put nix config in /etc/nix (system-wide, not affected by /tmp mount).
# Owned by ubuntu so write-nix-auth.sh (run as ubuntu) can append the GitHub
# access token to it at container start, before nix is ever invoked.
RUN mkdir -p /etc/nix && \
    { \
      echo "experimental-features = nix-command flakes"; \
      echo "accept-flake-config = true"; \
    } > /etc/nix/nix.conf && \
    chown -R ubuntu:ubuntu /etc/nix

# Writes nix's GitHub access token from RENOVATE_TOKEN into /etc/nix/nix.conf
# once, on disk. Renovate strips secrets from the env of any child process it
# spawns (postUpgradeTasks, customCommands, its own nix manager) unless
# exposeAllEnv is set, so forwarding the token via env at nix-call time is
# unreliable. A file on disk is read by nix regardless of which process
# invoked it or what env that process was given, so this sidesteps the
# restriction entirely instead of fighting it.
RUN { \
      echo '#!/bin/sh'; \
      echo 'set -e'; \
      echo 'if [ -n "${RENOVATE_TOKEN:-}" ]; then'; \
      echo '  if ! grep -q "^access-tokens" /etc/nix/nix.conf; then'; \
      echo '    echo "access-tokens = github.com=$RENOVATE_TOKEN" >> /etc/nix/nix.conf'; \
      echo '  fi'; \
      echo '  echo "[nix-auth] github.com access token configured"'; \
      echo 'else'; \
      echo '  echo "[nix-auth] RENOVATE_TOKEN not set, nix will fetch github.com unauthenticated"'; \
      echo 'fi'; \
    } > /opt/nix/write-nix-auth.sh && \
    chmod +x /opt/nix/write-nix-auth.sh

# Launcher wrapper baked into the image so nix.conf gets set up even when the
# renovate-operator runs the container with Command: ["renovate"], which
# resolves via $PATH and overrides the image ENTRYPOINT below.
RUN mkdir -p /opt/nix/wrapper && \
    { \
      echo '#!/bin/sh'; \
      echo 'set -e'; \
      echo '/opt/nix/write-nix-auth.sh'; \
      echo 'exec /usr/local/sbin/renovate "$@"'; \
    } > /opt/nix/wrapper/renovate && \
    chmod +x /opt/nix/wrapper/renovate

ENV PATH="/opt/nix/wrapper:/opt/nix/profile/bin:${PATH}"

COPY --chmod=755 entrypoint.sh /entrypoint.sh

USER ubuntu

ENTRYPOINT ["/entrypoint.sh"]
