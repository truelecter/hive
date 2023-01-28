# Nix Configuration

This repository is home to the nix code that builds my systems.

[![octoprint](https://img.shields.io/cirrus/github/truelecter/infra?label=octoprint&logo=nixos&logoColor=white&task=Build%20octoprint)][octoprint]
[![depsos](https://img.shields.io/cirrus/github/truelecter/infra?label=depsos&logo=nixos&logoColor=white&task=Build%20depsos)][depsos]
[![hyperos](https://img.shields.io/cirrus/github/truelecter/infra?label=hyperos&logo=nixos&logoColor=white&task=Build%20hyperos)][hyperos]
[![nas](https://img.shields.io/cirrus/github/truelecter/infra?label=nas&logo=nixos&logoColor=white&task=Build%20nas)][nas]
[![squadbook](https://img.shields.io/cirrus/github/truelecter/infra?label=squadbook&logo=nixos&logoColor=white&task=Build%20squadbook)][squadbook]

## Why Nix?

Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This flake is configured with the use of [digga][digga].

## Apply configs

### NixOS hosts

```bash
nix develop
deploy -s # some checks are currently broken
# OR
deploy -s ".<hostname>"
```

### Darwin hosts

```bash
nix develop
# While on darwin host deploy-rs does not support darwin currently
darwin-rebuild switch --flake .
```

[digga]: https://github.com/divnix/digga
[octoprint]: https://cirrus-ci.com/github/truelecter/infra/
[depsos]: https://cirrus-ci.com/github/truelecter/infra/
[hyperos]: https://cirrus-ci.com/github/truelecter/infra/
[nas]: https://cirrus-ci.com/github/truelecter/infra/
[squadbook]: https://cirrus-ci.com/github/truelecter/infra/
