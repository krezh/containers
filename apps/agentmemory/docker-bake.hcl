target "docker-metadata-action" {}

variable "APP" {
  default = "agentmemory"
}

variable "VERSION" {
  // renovate: datasource=npm depName=@agentmemory/agentmemory
  default = "0.9.27"
}

variable "SOURCE" {
  default = "https://github.com/rohitg00/agentmemory"
}

variable "WITH_LOCAL_EMBEDDINGS" {
  default = "false"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION               = "${VERSION}"
    WITH_LOCAL_EMBEDDINGS = "${WITH_LOCAL_EMBEDDINGS}"
  }
  labels = {
    "org.opencontainers.image.source"      = "${SOURCE}"
    "org.opencontainers.image.title"       = "agentmemory"
    "org.opencontainers.image.description" = "Persistent memory for AI coding agents (REST + MCP shim)"
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
