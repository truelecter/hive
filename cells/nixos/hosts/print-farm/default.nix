{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "aarch64-linux";
in {
  imports = [
    suites.base

    profiles.common.networking.tailscale
    profiles.faster-linux
    profiles.minimize

    inputs.cells.klipper.nixosModules.klipper
    inputs.cells.secrets.nixosProfiles.wifi

    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix
    ./wifi.nix
    ./network-switch.nix
    ./spoolman.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.rpi.overlays.kernel
      inputs.cells.rpi.overlays.dtmerge

      inputs.cells.klipper.overlays.klipper
    ];
  };

  networking = {
    hostName = "print-farm";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
