target "docker-metadata-action" {}

variable "APP" {
  default = "cdpg-vchord"
}

variable "VERSION" {
  // renovate: datasource=custom.pgimages depName=registry.developers.crunchydata.com/crunchydata/crunchy-postgres versioning=regex:^ubi(?<major>\d+)-(?<minor>\d+)\.(?<patch>\d+)-(?<build>\d+)$
  default = "ubi9-16.11-2547"
}

variable "PG_VERSION" {
  default = "16"
}

variable "VCHORD_VERSION" {
  default = "0.4.3"
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
    "linux/amd64",
    "linux/arm64"
  ]
}
