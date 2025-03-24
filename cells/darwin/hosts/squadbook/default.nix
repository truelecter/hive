{
  suites,
  lib,
  inputs,
  profiles,
  ...
}: let
  system = "aarch64-darwin";
in {
  imports = [
    suites.base
    suites.editors
    suites.system-preferences
    suites.games

    profiles.security.yubikey
    profiles.three-d-print

    profiles.common.networking.tailscale
    profiles.common.remote-builders.x86
    profiles.common.remote-builders.aarch

    profiles.users."andrii.panasiuk"
    profiles.users.root

    ./aarch-builder.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.common.overlays.latest-overrides
      inputs.cells.common.overlays.common-packages
    ];
  };

  # Needed for cursor to work
  home-manager.users."andrii.panasiuk" = {
    imports = [./vscode.nix];
    disabledModules = [
      "${inputs.home}/modules/programs/vscode.nix"
    ];
  };

  networking = {
    hostName = lib.mkForce "squadbook";
    computerName = "Andrii.Panasiuk";
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
      "Office VPN"
      "Community VPN"
      "Tailscale Tunnel"
    ];
  };

  system.stateVersion = 4;
}
