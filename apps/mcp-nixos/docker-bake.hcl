target "docker-metadata-action" {}

variable "APP" {
  default = "mcp-nixos"
}

variable "VERSION" {
  // renovate: datasource=pypi depName=mcp-nixos
  default = "2.4.3"
}

variable "SOURCE" {
  default = "https://github.com/utensils/mcp-nixos"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source"      = "${SOURCE}"
    "org.opencontainers.image.title"       = "mcp-nixos"
    "org.opencontainers.image.description" = "MCP server for NixOS, nixpkgs, Home Manager & nix-darwin search"
  }
}

target "image-local" {
  inherits = ["image"]
  output   = ["type=docker"]
  tags     = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
