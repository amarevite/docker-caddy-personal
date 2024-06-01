ARG CADDY_VERSION=2.8.1

# Builder
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/porkbun \
    --with github.com/caddyserver/cache-handler \
    --with github.com/caddyserver/replace-response \
    --with github.com/abiosoft/caddy-exec

# Container
FROM caddy:${CADDY_VERSION}-alpine

# install additional packages
RUN apk add --no-cache \
    tzdata \
    micro \
    curl \
    xh

LABEL org.opencontainers.image.vendor="amarevite"
LABEL org.opencontainers.image.source="https://github.com/amarevite/docker-caddy-personal"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
