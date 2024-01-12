#!/usr/bin/env bash
version=$(curl -sX GET "https://api.github.com/repos/weaveworks/tf-controller/tags" | jq -r '.[].name' | grep -v "\-rc" | head -n 1)
printf "%s\n" "${version#*v}"

