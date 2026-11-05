[![Check for Updates](https://github.com/amarevite/docker-caddy-personal/actions/workflows/check-update.yml/badge.svg)](https://github.com/amarevite/docker-caddy-personal/actions/workflows/check-update.yml)

# docker-caddy-personal

Custom Caddy docker image that adds the following plugins and tools:
- Plugins:
	- [porkbun](https://github.com/caddy-dns/porkbun)
	- [cache-handler](https://github.com/caddyserver/cache-handler)
	- [replace-response](https://github.com/caddyserver/replace-response)
	- [crowdsec-bouncer](https://github.com/hslatman/caddy-crowdsec-bouncer)
- Tools:
	- [`tzdata`](https://wiki.alpinelinux.org/wiki/Setting_the_timezone) for using the `TZ` environment variable
	- [`micro`](https://github.com/zyedidia/micro) terminal editor
	- `curl`
	- [`xh`](https://github.com/ducaale/xh) (similar to curl but I prefer it)

## Usage

The image is availabe via [GitHub Packages](https://github.com/amarevite/docker-caddy-personal/pkgs/container/docker-caddy-personal):

- `ghcr.io/amarevite/docker-caddy-personal:latest`
