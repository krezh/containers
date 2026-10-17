target "docker-metadata-action" {}

variable "APP" {
  default = "whisparr"
}

variable "VERSION" {
  // renovate: datasource=custom.whisparr-eros depName=whisparr-eros versioning=loose
  default = "3.6.5-release.1886"
}

variable "SOURCE" {
  default = "https://github.com/Whisparr/Whisparr-Eros"
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
    "org.opencontainers.image.title"       = "whisparr"
    "org.opencontainers.image.description" = "Whisparr v3 Eros container image"
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
