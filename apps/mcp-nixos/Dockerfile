# syntax=docker/dockerfile:1
ARG VERSION

FROM docker.io/library/python:3.13-alpine

ARG VERSION

# Alpine already provides nobody:nogroup at 65534:65534 — reuse it.
RUN apk add --no-cache catatonit \
    && pip install --no-cache-dir --root-user-action=ignore "mcp-nixos==${VERSION}" \
    && mkdir -p /home/nobody \
    && chown 65534:65534 /home/nobody

LABEL org.opencontainers.image.source="https://github.com/utensils/mcp-nixos" \
      org.opencontainers.image.title="mcp-nixos" \
      org.opencontainers.image.description="MCP server for NixOS, nixpkgs, Home Manager & nix-darwin search"

USER nobody:nogroup
WORKDIR /home/nobody

ENTRYPOINT ["/usr/bin/catatonit", "--", "mcp-nixos"]
