#!/usr/bin/env bash
channel=$1
# renovate: datasource=docker depName=docker.io/valkey/valkey
version="7.2.5"
printf "%s" "${version}"

