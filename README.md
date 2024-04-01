# Nix Configuration

This repository is home to the nix code that builds my systems.

<!-- Disable octoprint for now -->
<!-- [![octoprint](https://img.shields.io/cirrus/github/truelecter/hive?label=octoprint&logo=nixos&logoColor=white&task=Build%20octoprint)][octoprint] -->

[![tl-wsl](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tl-wsl.yaml?event=push&logo=nixos&logoColor=white&label=tl-wsl)][tl-wsl]
[![depsos](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-depsos.yaml?event=push&logo=nixos&logoColor=white&label=depsos)][depsos]
[![nas](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-nas.yaml?event=push&logo=nixos&logoColor=white&label=nas)][nas]
[![squadbook](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-squadbook.yaml?event=push&logo=nixos&logoColor=white&label=squadbook)][squadbook]
[![oracle](https://img.shields.io/circleci/build/github/truelecter/hive/master?logo=nixos&logoColor=white&label=oracle)][oracle]
[![voron](https://img.shields.io/circleci/build/github/truelecter/hive/master?logo=nixos&logoColor=white&label=voron)][voron]

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

#### First time

Bootstrap default aarch64-linux builder

```bash
nix run github:nixos/nixpkgs/nixpkgs-23.11-darwin#darwin.linux-builder
nix build --builders 'builder@localhost aarch64-linux /etc/nix/builder_ed25519' github:truelecter/hive#squadbook
```

#### Switch configuration

```bash
darwin-rebuild switch --flake .
```

[hive]: https://github.com/divnix/hive

<!-- [octoprint]: <https://cirrus-ci.com/github/truelecter/infra/> -->
<!-- GitHub Actions -->

[tl-wsl]: https://github.com/truelecter/hive/actions/workflows/build-tl-wsl.yaml
[depsos]: https://github.com/truelecter/hive/actions/workflows/build-depsos.yaml
[nas]: https://github.com/truelecter/hive/actions/workflows/build-nas.yaml
[squadbook]: https://github.com/truelecter/hive/actions/workflows/build-squadbook.yaml

<!-- CirrusCI -->


<!-- CircleCI -->

[voron]: https://app.circleci.com/pipelines/github/truelecter/hive?branch=master
[oracle]: https://app.circleci.com/pipelines/github/truelecter/hive?branch=master
