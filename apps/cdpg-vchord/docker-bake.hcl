target "docker-metadata-action" {}

variable "PG_VERSION" {
  default = "16"
}

variable "VCHORD_VERSION" {
  default = "0.4.3"
}

variable "CRUNCHYDATA_VERSION" {
  // renovate: datasource=custom.pgimages depName=registry.developers.crunchydata.com/crunchydata/crunchy-postgres versioning=regex:^ubi(?<major>\d+)-(?<minor>\d+)\.(?<patch>\d+)-(?<build>\d+)$
  default = "ubi9-16.10-2534"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${CRUNCHYDATA_VERSION}"
    PG_VERSION = "${PG_VERSION}"
    VCHORD_VERSION = "${VCHORD_VERSION}"
    CRUNCHYDATA_VERSION = "${CRUNCHYDATA_VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "https://github.com/krezh/containers"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}
