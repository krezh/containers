target "docker-metadata-action" {}

variable "APP" {
  default = "renovate-nix"
}

variable "VERSION" {
  // renovate: datasource=docker depName=ghcr.io/renovatebot/renovate
  default = "43.163.2"
}

variable "NIX_VERSION" {
  // renovate: datasource=github-tags depName=NixOS/nix
  default = "2.34.7"
}

variable "SOURCE" {
  default = "https://github.com/krezh/containers"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION  = "${VERSION}"
    NIX_VERSION = "${NIX_VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
