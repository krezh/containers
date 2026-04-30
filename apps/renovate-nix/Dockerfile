ARG VERSION
ARG NIX_VERSION

FROM ghcr.io/renovatebot/renovate:${VERSION}

ARG NIX_VERSION
ENV NIX_VERSION=${NIX_VERSION}

USER root
RUN mkdir -p /nix && chown ubuntu:ubuntu /nix

USER ubuntu

RUN <<EOT
set -e
echo "Installing Nix ${NIX_VERSION}..."
mkdir -p /home/ubuntu/.config/nix
curl -SsL "https://releases.nixos.org/nix/nix-${NIX_VERSION}/install" | sh -s -- --no-daemon
cat > /home/ubuntu/.config/nix/nix.conf <<EOF
experimental-features = nix-command flakes
accept-flake-config = true
EOF
echo "Nix installation complete"
EOT

ENV PATH="/home/ubuntu/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"
ENV NIX_CONF_DIR="/home/ubuntu/.config/nix"
