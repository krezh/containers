#!/usr/bin/env bash
channel=$1
# renovate: datasource=docker depName=docker.io/valkey/valkey
version="8.0.0"
printf "%s" "${version}"

