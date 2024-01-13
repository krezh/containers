#!/usr/bin/env bash

for i in {1..3}; do
    version="$(curl -sSL "https://codeberg.org/api/v1/repos/readeck/readeck/releases/latest" | jq --raw-output '.tag_name')"
    version="${version#*v}"
    version="${version#*release-}"
    if [[ -z "$version" ]]; then
        echo -e "Failed to get latest version. Retrying in 5 seconds... $i/3"
        sleep 5
    else
        printf "%s" "${version}"
        break
    fi
done

