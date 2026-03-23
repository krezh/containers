target "docker-metadata-action" {}

variable "APP" {
  default = "cdpg-vchord-18"
}

variable "VERSION" {
  // renovate: datasource=custom.crunchy-postgres-18 depName=crunchy-postgres-18 versioning=regex:^ubi(?<major>\d+)-(?<minor>\d+)\.(?<patch>\d+)-(?<build>\d+)$
  default = "ubi9-18.3-2610"
}

variable "PG_VERSION" {
  default = "18"
}

variable "VCHORD_VERSION" {
  default = "1.0.0"
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
    VERSION = "${VERSION}"
    PG_VERSION = "${PG_VERSION}"
    VCHORD_VERSION = "${VCHORD_VERSION}"
    CRUNCHYDATA_VERSION = "${VERSION}"
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
    "linux/amd64"
  ]
}
