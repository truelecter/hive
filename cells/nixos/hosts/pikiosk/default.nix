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

    inputs.cells.secrets.nixosProfiles.wifi
    inputs.cells.secrets.nixosProfiles.weather-kiosk

    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix
    ./kiosk.nix
    ./wifi.nix
    ./weather.nix
    ./display.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.rpi.overlays.kernel
      inputs.cells.rpi.overlays.dtmerge
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "pikiosk";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
