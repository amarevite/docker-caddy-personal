#!/bin/bash

# get latest version of a docker image:
# 1) fetch latest tag info from github api
# 2) use jq to extract the rag_name (version number)
# 3) use sed to remove the v from v2.7.5
getLatestVersion() {
    local result=$(
        curl -s https://api.github.com/repos/caddyserver/caddy/releases/latest | \
        jq -r '.tag_name' | \
        sed 's/v//'
    )

    echo "${result}"
}

LATEST_CADDY_VERSION=$(getLatestVersion "library/caddy")
LATEST_CUSTOM_VERSION=$(
    cat Dockerfile | \
    head -n 1 | \
    grep -E -oh '[0-9](\.[0-9](\.[0-9])?)?$'
)

echo "Latest version of Caddy: $LATEST_CADDY_VERSION"
echo "Latest version of this image: $LATEST_CUSTOM_VERSION"

if [[ $LATEST_CADDY_VERSION == $LATEST_CUSTOM_VERSION ]]; then
    echo "The image is up-to-date"
    exit 0
fi

if [[ ! -z $GITHUB_OUTPUT ]]; then
    echo "LATEST_CADDY_VERSION=$LATEST_CADDY_VERSION" >> $GITHUB_OUTPUT
fi

echo "This image is not up-to-date. Updating to $LATEST_CADDY_VERSION"

cp Dockerfile Dockerfile.tmp
echo "ARG CADDY_VERSION=$LATEST_CADDY_VERSION" > Dockerfile
cat Dockerfile.tmp | tail -n+2 >> Dockerfile
rm Dockerfile.tmp
