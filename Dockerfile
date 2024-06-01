ARG CADDY_VERSION=2.7.6

# Builder
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --replace github.com/caddy-dns/porkbun \
    --replace github.com/caddyserver/cache-handler \
    --replace github.com/caddyserver/replace-response \
    --replace github.com/abiosoft/caddy-exec

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
