# Nix Configuration

This repository is home to the nix code that builds my systems.

[![octoprint](https://img.shields.io/cirrus/github/truelecter/hive?label=octoprint&logo=nixos&logoColor=white&task=Build%20octoprint)][octoprint]
[![depsos](https://img.shields.io/cirrus/github/truelecter/hive?label=depsos&logo=nixos&logoColor=white&task=Build%20depsos)][depsos]
[![hyperos](https://img.shields.io/cirrus/github/truelecter/hive?label=hyperos&logo=nixos&logoColor=white&task=Build%20hyperos)][hyperos]
[![nas](https://img.shields.io/cirrus/github/truelecter/hive?label=nas&logo=nixos&logoColor=white&task=Build%20nas)][nas]
[![squadbook](https://img.shields.io/cirrus/github/truelecter/hive?label=squadbook&logo=nixos&logoColor=white&task=Build%20squadbook)][squadbook]
[![oracle](https://img.shields.io/cirrus/github/truelecter/hive?label=oracle&logo=nixos&logoColor=white&task=Build%20oracle)][oracle]

## Why Nix?

Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This flake is configured with the use of [hive][hive].

## Apply configs

### NixOS hosts

```bash
colmena build
colmena apply
# OR
colmena apply --on "nixos-$HOST"
```

### Darwin hosts

```bash
darwin-rebuild switch --flake .
```

[hive]: https://github.com/divnix/hive
[octoprint]: https://cirrus-ci.com/github/truelecter/infra/
[oracle]: https://cirrus-ci.com/github/truelecter/infra/
[depsos]: https://cirrus-ci.com/github/truelecter/infra/
[hyperos]: https://cirrus-ci.com/github/truelecter/infra/
[nas]: https://cirrus-ci.com/github/truelecter/infra/
[squadbook]: https://cirrus-ci.com/github/truelecter/infra/
