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
    profiles.common.remote-builders

    profiles.users."andrii.panasiuk"
    profiles.users.root

    ./aarch-builder.nix
  ];

  bee.system = system;
  bee.home = inputs.home-unstable;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.latest {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.common.overlays.latest-overrides
      inputs.cells.common.overlays.common-packages
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
