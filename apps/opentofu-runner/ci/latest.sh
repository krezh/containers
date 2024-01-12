#!/usr/bin/env bash
version=$(curl -sX GET "https://api.github.com/repos/weaveworks/tf-controller/tags" | jq --raw-output '.[].name' 2>/dev/null | grep -v "\-rc" | head -n 1)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
