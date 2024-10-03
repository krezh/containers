#!/usr/bin/env bash
channel=$1
# renovate: datasource=docker depName=docker.io/valkey/valkey
version="8.0.1"
printf "%s" "${version}"

