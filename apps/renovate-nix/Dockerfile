ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Create /nix directory with correct permissions
RUN mkdir -p /nix && chown -R ubuntu:ubuntu /nix

# Copy and set up entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ubuntu

ENV PATH="/home/ubuntu/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"
ENV NIX_CONF_DIR="/home/ubuntu/.config/nix"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
