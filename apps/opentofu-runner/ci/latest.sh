#!/usr/bin/env bash
#version=$(curl -sX GET "https://api.github.com/repos/flux-iac/tf-controller-old/tags" | jq --raw-output '.[].name' 2>/dev/null | grep -v "\-rc" | head -n 1)
version="0.16.0-rc.3"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
