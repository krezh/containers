#!/usr/bin/env bash
channel=$1
regex='^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$'
url="https://registry.hub.docker.com/v2/repositories/valkey/valkey/tags?ordering=name&name=$channel"
version=$(curl -s "$url" | jq --raw-output --arg regex "$regex" --arg s "$channel" '.results[] | select(.name | contains("unstable") | not) | select(.name | contains($s)) | .name | select(test($regex))' 2>/dev/null | head -n1)
version="${version#*v}"
version="${version%-"${channel}"}"
printf "%s" "${version}"

