{
  inputs,
  suites,
  profiles,
  overlays,
  ...
}: let
  system = "aarch64-linux";
in {
  imports = [
    suites.base

    profiles.common.networking.tailscale
    profiles.faster-linux
    profiles.minimize

    inputs.cells.secrets.nixosProfiles.wifi
    inputs.cells.klipper.nixosModules.klipper

    inputs.cells.rockchip.nixosModules.rockchip

    ./hardware-configuration.nix
    ./klipper-screen-test.nix
    ./moonraker.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.rockchip.overlays.btt-pi-v2-kernel

      inputs.cells.klipper.overlays.klipper
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "bttpitest";
    firewall.enable = false;
  };

  system.stateVersion = "24.11";
}
