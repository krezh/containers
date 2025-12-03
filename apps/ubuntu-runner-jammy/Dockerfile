# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS builder

ARG RUNNER_VERSION=2.321.0
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /build

# Install required tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    qemu-utils \
    libguestfs-tools \
    linux-image-generic \
    && rm -rf /var/lib/apt/lists/*

# Download Ubuntu cloud image
RUN curl -fsSL -o ubuntu-original.img \
    "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"

# Create a new 50GB image
RUN qemu-img create -f qcow2 ubuntu.img 50G

# Set environment variables for libguestfs
ENV LIBGUESTFS_BACKEND=direct

# Resize and expand the filesystem to 50GB
RUN virt-resize --expand /dev/sda1 ubuntu-original.img ubuntu.img && \
    rm ubuntu-original.img

# Customize the image with virt-customize
RUN virt-customize -a ubuntu.img \
    --run-command 'apt-get update' \
    --install 'ca-certificates,curl,jq,git,tar,sudo,docker.io,docker-buildx,docker-compose-v2' \
    --run-command 'mkdir -p /opt/runner' \
    --run-command "curl -o /opt/runner/actions-runner-linux.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" \
    --run-command 'cd /opt/runner && tar xzf actions-runner-linux.tar.gz && rm actions-runner-linux.tar.gz' \
    --run-command 'cd /opt/runner && ./bin/installdependencies.sh' \
    --run-command 'useradd -m -s /bin/bash runner' \
    --run-command 'usermod -aG docker runner' \
    --run-command "echo 'runner ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/runner" \
    --run-command 'chmod 0440 /etc/sudoers.d/runner' \
    --run-command 'chown -R runner:runner /opt/runner' \
    --run-command 'systemctl enable docker' \
    --run-command 'apt-get clean && rm -rf /var/lib/apt/lists/*'

# Convert to qcow2 format with compression
RUN qemu-img convert -f qcow2 -O qcow2 -c ubuntu.img disk.qcow2

# Create the final containerDisk image
FROM scratch

COPY --from=builder --chown=107:107 /build/disk.qcow2 /disk/disk.img
