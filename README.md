# Nix Configuration

This repository contains the Nix code that builds my systems using flake-parts.

## Why Nix?

Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This flake is configured using [flake-parts](https://github.com/hercules-ci/flake-parts) for a modular approach.

## Repository Structure

- `/nixos` - NixOS configurations
  - `/nixos/hosts/x86_64` - x86_64 NixOS hosts
    - [![tl-wsl](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tl-wsl.yaml?event=push&logo=nixos&logoColor=white&label=tl-wsl&style=social)][tl-wsl]
    - [![depsos](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-depsos.yaml?event=push&logo=nixos&logoColor=white&label=depsos)][depsos]
    - [![nas](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-nas.yaml?event=push&logo=nixos&logoColor=white&label=nas)][nas]
    - [![sirius](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-sirius.yaml?event=push&logo=nixos&logoColor=white&label=sirius)][sirius]
  - `/nixos/hosts/aarch64` - aarch64 NixOS hosts
    - [![voron](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-voron.yaml?event=push&logo=nixos&logoColor=white&label=voron)][voron]
    - [![oracle](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-oracle.yaml?event=push&logo=nixos&logoColor=white&label=oracle)][oracle]
    - [![vzbot235](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-vzbot235.yaml?event=push&logo=nixos&logoColor=white&label=vzbot235)][vzbot235]
    - [![tiny-m](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tiny-m.yaml?event=push&logo=nixos&logoColor=white&label=tiny-m)][tiny-m]
- `/darwin` - Darwin configurations
  - `/darwin/hosts` - aarch64-darwin hosts
    - [![squadbook](https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-squadbook.yaml?event=push&logo=nixos&logoColor=white&label=squadbook)][squadbook]
- `/home` - Home-manager configurations
- `/parts` - flake-parts modules
  - `/parts/klipper` - Klipper 3D printer related configurations
  - `/parts/raspberry-pi` - Raspberry Pi specific configurations
  - `/parts/rockchip` - Rockchip SoC configurations
  - `/parts/k8s` - K3S wrappers and version pinning
  - `/parts/minecraft-servers` - Minecraft server configurations
- `/profiles` - Shared system profiles
- `/lib` - Helper functions and utilities
- `/secrets` - Encrypted secrets (using sops-nix)
- `/shell` - Development shell configurations

## Apply Configurations

### NixOS Hosts

For NixOS hosts, you can use [deploy-rs](https://github.com/serokell/deploy-rs) to deploy configurations:

```bash
# Build all hosts
deploy-rs .

# Build a specific host
deploy-rs . -- --host <hostname>
```

### Darwin Hosts

For macOS hosts running nix-darwin:

```bash
# First-time setup - bootstrap aarch64-linux builder
nix run github:nixos/nixpkgs/nixpkgs-23.11-darwin#darwin.linux-builder
nix build --builders 'builder@localhost aarch64-linux /etc/nix/builder_ed25519' .#darwinConfigurations.<hostname>.system

# Switch configuration
darwin-rebuild switch --flake .#<hostname>
```

## Development

A development shell is available with useful utilities:

```bash
nix develop
```

<!-- GitHub Actions -->
[tl-wsl]: https://github.com/truelecter/hive/actions/workflows/build-tl-wsl.yaml
[depsos]: https://github.com/truelecter/hive/actions/workflows/build-depsos.yaml
[nas]: https://github.com/truelecter/hive/actions/workflows/build-nas.yaml
[sirius]: https://github.com/truelecter/hive/actions/workflows/build-sirius.yaml
[squadbook]: https://github.com/truelecter/hive/actions/workflows/build-squadbook.yaml
[vzbot235]: https://github.com/truelecter/hive/actions/workflows/build-vzbot235.yaml
[tiny-m]: https://github.com/truelecter/hive/actions/workflows/build-tiny-m.yaml
[voron]: https://github.com/truelecter/hive/actions/workflows/build-voron.yaml
[oracle]: https://github.com/truelecter/hive/actions/workflows/build-oracle.yaml
