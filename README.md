# Nix Configuration
This repository is home to the nix code that builds my systems.

## Why Nix?
Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.


This flake is configured with the use of [digga][digga].

[digga]: https://github.com/divnix/digga

## Apply configs
### NixOS hosts
```bash
nix develop
deploy -s # some checks are currently broken
```
### Darwin hosts
```bash
nix develop
# While on darwin host deploy-rs does not support darwin currently
darwin-rebuild switch --flake .
```
