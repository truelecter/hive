# Nix Configuration

This repository contains the Nix code that builds my systems using flake-parts.

## Why Nix?

Nix allows for easy to manage, collaborative, reproducible deployments. This means that once something is setup and configured once, it works forever. If someone else shares their configuration, anyone can make use of it.

This flake is configured using [flake-parts](https://github.com/hercules-ci/flake-parts) for a modular approach.

## Repository Structure

- `/nixos` - NixOS configurations
  - `/nixos/hosts/x86_64` - x86_64 NixOS hosts
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-tl-wsl.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tl-wsl.yaml?event=push&logo=nixos&logoColor=white&label=tl-wsl" alt="tl-wsl"></a> - WSL system
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-depsos.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-depsos.yaml?event=push&logo=nixos&logoColor=white&label=depsos" alt="depsos"></a> - Server for publically hosted services
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-nas.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-nas.yaml?event=push&logo=nixos&logoColor=white&label=nas" alt="nas"></a> - NAS with some multimedia stuff
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-sirius.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-sirius.yaml?event=push&logo=nixos&logoColor=white&label=sirius" alt="sirius"></a> - Home Assistant and 3D printer coordination
  - `/nixos/hosts/aarch64` - aarch64 NixOS hosts
    - 3D Printers:
      - <a href="https://github.com/truelecter/hive/actions/workflows/build-voron.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-voron.yaml?event=push&logo=nixos&logoColor=white&label=voron" alt="voron"></a> - Voron 2.4 300mm
      - <a href="https://github.com/truelecter/hive/actions/workflows/build-vzbot235.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-vzbot235.yaml?event=push&logo=nixos&logoColor=white&label=vzbot235" alt="vzbot235"></a> - VzBot 235
      - <a href="https://github.com/truelecter/hive/actions/workflows/build-tiny-m.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tiny-m.yaml?event=push&logo=nixos&logoColor=white&label=tiny-m" alt="tiny-m"></a> - Tiny-M 150mm
    - Misc:
      - <a href="https://github.com/truelecter/hive/actions/workflows/build-oracle.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-oracle.yaml?event=push&logo=nixos&logoColor=white&label=oracle" alt="oracle"></a> - Game servers and remote builder
- `/darwin` - Darwin configurations
  - `/darwin/hosts` - aarch64-darwin hosts
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-squadbook.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-squadbook.yaml?event=push&logo=nixos&logoColor=white&label=squadbook" alt="squadbook"></a> - Manual workstation
    - <a href="https://github.com/truelecter/hive/actions/workflows/build-tl-mm4.yaml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/truelecter/hive/build-tl-mm4.yaml?event=push&logo=nixos&logoColor=white&label=tl-mm4" alt="tl-mm4"></a> - aarch64-darwin and aarch64-linux builder
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
deploy --skip-checks '.#<hostname>'
```

### Darwin Hosts

For macOS hosts running nix-darwin:

```bash
# First-time setup - bootstrap aarch64-linux builder
nix run github:nixos/nixpkgs/nixpkgs-23.11-darwin#darwin.linux-builder
nix build --builders 'builder@localhost aarch64-linux /etc/nix/builder_ed25519' .#darwinConfigurations.<hostname>.system

# Switch configuration (local)
darwin-rebuild switch --flake .#<hostname>

# Switch configuration (remote)
deploy --skip-checks '.#<hostname>'
```

## Development

A development shell is available with useful utilities:

```bash
nix develop
```

## Resources

### Core

- [hercules-ci/flake-parts](https://github.com/hercules-ci/flake-parts) - Core of this flake.
- [LnL7/nix-darwin](https://github.com/LnL7/nix-darwin) - Darwin hosts management.
- [nix-community/NixOS-WSL](https://github.com/nix-community/NixOS-WSL) - WSL support for NixOS.
- [nix-community/home-manager](https://github.com/nix-community/home-manager) - Dotfiles and user management.
- [serokell/deploy-rs](https://github.com/serokell/deploy-rs) - Deployment tool for all the hosts.
- [Mic92/sops-nix](https://github.com/Mic92/sops-nix) - Secrets management.

### Repo management

- [numtide/devshell](https://github.com/numtide/devshell) - Shell environment for all the tools for this flake.
- [nix-community/nixago](https://github.com/nix-community/nixago) - Repo config file management.
- [berberman/nvfetcher](https://github.com/berberman/nvfetcher) - Source version management.

### Libraries

- [nix-community/haumea](https://github.com/nix-community/haumea) - Filesystem-based module system.
- [nixos/nixos-hardware](https://github.com/nixos/nixos-hardware) - Useful hardware-configuration modules.
- [nabam/nixos-rockchip](https://github.com/nabam/nixos-rockchip) - Useful modules for Rockchip SoCs.
- [nix-community/pyproject.nix](https://github.com/nix-community/pyproject.nix) - Python libraries fetching for certain packages.
- [nix-community/nix-vscode-extensions](https://github.com/nix-community/nix-vscode-extensions) - VSCode extensions management.
- [nix-community/nixos-vscode-server](https://github.com/nix-community/nixos-vscode-server) - VSCode server fixes for NixOS.

### Notable mentions

- [linyinfeng/dotfiles](https://github.com/linyinfeng/dotfiles) - Big inspiration for this flake structure and some library functions.
