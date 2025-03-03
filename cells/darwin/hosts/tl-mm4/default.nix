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

    profiles.common.networking.tailscale
    profiles.common.remote-builder
    profiles.common.remote-builders.x86
    profiles.common.remote-builders.aarch

    profiles.users."truelecter"
    profiles.users.root

    ./aarch-builder.nix
  ];

  _module.args = {
    inherit profiles;
    nixpkgs = inputs.nixos;
  };

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

  networking = {
    hostName = lib.mkForce "tl-mm4";
    computerName = "TL-MM4";
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
