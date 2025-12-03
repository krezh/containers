target "docker-metadata-action" {}

variable "APP" {
  default = "ubuntu-runner-jammy"
}

variable "VERSION" {
  default = "22.04"
}

variable "SOURCE" {
  default = "https://github.com/krezh/containers"
}

group "default" {
  targets = ["image-local"]
}

variable "RUNNER_VERSION" {
  // renovate: datasource=github-releases depName=actions/runner
  default = "2.330.0"
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    UBUNTU_VERSION = "${VERSION}"
    RUNNER_VERSION = "${RUNNER_VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${RUNNER_VERSION}"]
  # Enable security.insecure for virt-customize to work
  allow = ["security.insecure"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64"
  ]
}
