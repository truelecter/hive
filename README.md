# Nix Configuration

This repository is home to the nix code that builds my systems.

<!-- Disable octoprint for now -->
<!-- [![octoprint](https://img.shields.io/cirrus/github/truelecter/hive?label=octoprint&logo=nixos&logoColor=white&task=Build%20octoprint)][octoprint] -->

[![tl-wsl](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tl-wsl.yaml?event=push&logo=nixos&logoColor=white&label=tl-wsl)][tl-wsl]
[![depsos](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-depsos.yaml?event=push&logo=nixos&logoColor=white&label=depsos)][depsos]
[![hyperos](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-hyperos.yaml?event=push&logo=nixos&logoColor=white&label=hyperos)][hyperos]
[![nas](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-nas.yaml?event=push&logo=nixos&logoColor=white&label=nas)][nas]
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

<!-- [octoprint]: <https://cirrus-ci.com/github/truelecter/infra/> -->
<!-- GitHub Actions -->

[tl-wsl]: https://github.com/truelecter/hive/actions/workflows/build-tl-wsl.yaml
[depsos]: https://github.com/truelecter/hive/actions/workflows/build-depsos.yaml
[hyperos]: https://github.com/truelecter/hive/actions/workflows/build-hyperos.yaml
[nas]: https://github.com/truelecter/hive/actions/workflows/build-nas.yaml

<!-- CirrusCI -->

[oracle]: https://cirrus-ci.com/github/truelecter/hive/
[squadbook]: https://cirrus-ci.com/github/truelecter/hive/
