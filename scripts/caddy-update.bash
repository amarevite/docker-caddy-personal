#!/bin/bash

# get latest version of a docker image:
# 1) fetch latest tag info from github api
# 2) use jq to extract the rag_name (version number)
# 3) use sed to remove the v from v2.7.5
getLatestVersion() {
  local result
  result=$(
    curl --silent https://api.github.com/repos/caddyserver/caddy/releases/latest | \
    jq --raw-output '.tag_name' | \
    sed 's/v//'
  )
  echo "${result}"
}

LATEST_CADDY_VERSION=$(getLatestVersion)
CURRENT_CUSTOM_VERSION=$(grep --perl-regexp --only-matching --no-filename '^ARG CADDY_VERSION=\K[\d\.]+$' Containerfile)

echo "Latest version of Caddy: $LATEST_CADDY_VERSION"
echo "Current version of this image: $CURRENT_CUSTOM_VERSION"

if [[ "$LATEST_CADDY_VERSION" == "$CURRENT_CUSTOM_VERSION" ]]; then
  echo "The image is up-to-date"
  if [[ ! -z "$GITHUB_OUTPUT" ]]; then echo "should-build=false" >> "$GITHUB_OUTPUT"; fi
  exit 0
fi

if [[ ! -z "$GITHUB_OUTPUT" ]]; then
  echo "LATEST_CADDY_VERSION=$LATEST_CADDY_VERSION" >> "$GITHUB_OUTPUT"
  echo "should-build=true" >> "$GITHUB_OUTPUT"
fi

echo "This image is not up-to-date. Updating from $CURRENT_CUSTOM_VERSION to $LATEST_CADDY_VERSION"

NEW_ARG_STRING="ARG CADDY_VERSION=$LATEST_CADDY_VERSION"
sed --in-place "s#^ARG CADDY_VERSION=.*#${NEW_ARG_STRING}#" Containerfile
