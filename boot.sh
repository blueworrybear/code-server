#!/usr/bin/env bash
envsubst < /etc/traefik/provider.template.toml | sudo tee /etc/traefik/provider.toml
envsubst < /etc/traefik/traefik.template.toml | sudo tee /etc/traefik/traefik.toml
sudo traefik --log=true&
dumb-init fixuid -q /usr/bin/code-server --bind-addr 0.0.0.0:8080 .
