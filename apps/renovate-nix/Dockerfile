ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root

# Install Nix using containerbase (required for renovate compatibility)
RUN containerbase-cli install tool nix ${NIX_VERSION}

USER ubuntu

# Configure Nix settings in user home (where containerbase nix reads it)
RUN mkdir -p "$HOME/.config/nix" && \
    { \
      echo "experimental-features = nix-command flakes"; \
      echo "accept-flake-config = true"; \
    } > "$HOME/.config/nix/nix.conf"
