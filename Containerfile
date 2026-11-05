ARG CADDY_VERSION=2.11.7
ARG LIBRARY_PREFIX=docker.io/library

# xcaddy build layer
FROM ${LIBRARY_PREFIX}/caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
      --with github.com/caddyserver/cache-handler \
      --with github.com/caddyserver/replace-response \
      --with github.com/caddyserver/transform-encoder \
      --with github.com/caddy-dns/porkbun \
      --with github.com/mholt/caddy-l4 \
      --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main \
      --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
      --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@main

# Final image layer
FROM ${LIBRARY_PREFIX}/caddy:${CADDY_VERSION}-alpine

RUN apk add --no-cache \
      tzdata micro curl xh

LABEL org.opencontainers.image.vendor="amarevite"
LABEL org.opencontainers.image.source="https://github.com/amarevite/docker-caddy-personal"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
