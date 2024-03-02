[![Check for Updates](https://github.com/amarevite/docker-caddy-personal/actions/workflows/check-update.yml/badge.svg)](https://github.com/amarevite/docker-caddy-personal/actions/workflows/check-update.yml)

# docker-caddy-personal

Custom Caddy docker image that adds the following plugins and tools:
- Plugins:
	- [porkbun](https://github.com/caddy-dns/porkbun)
	- [cache-handler](https://github.com/caddyserver/cache-handler)
	- [replace-response](https://github.com/caddyserver/replace-response)
	- [caddy-exec](https://github.com/abiosoft/caddy-exec)
- Tools:
	- [`tzdata`](https://wiki.alpinelinux.org/wiki/Setting_the_timezone) so you can use the `TZ` environment variable
	- [`micro`](https://github.com/zyedidia/micro) terminal editor
	- `curl`
	- [`xh`](https://github.com/ducaale/xh) (similar to curl but i prefer it)

## Usage

The image is availabe via [GitHub Packages](https://github.com/amarevite/docker-caddy-personal/pkgs/container/docker-caddy-personal).

- `ghcr.io/amarevite/docker-caddy-porkbun-cachehandler:latest` (latest version)
- `ghcr.io/amarevite/docker-caddy-porkbun-cachehandler:2.7.6` (version `2.7.6`)

It should support whatever platforms [the main Caddy image](https://hub.docker.com/_/caddy) supports, but I'm not checking anything other than x86-64 since that's all I use.
