{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    suites.base

    profiles.common.networking.tailscale
    profiles.faster-linux
    profiles.minimize

    inputs.cells.secrets.nixosProfiles.wifi
    inputs.cells.secrets.nixosProfiles.weather-kiosk

    ./hardware-configuration.nix
    ./kiosk.nix
    ./wifi.nix
    ./weather.nix
  ];

  bee.system = system;
  bee.home = inputs.home-unstable;
  bee.pkgs = import inputs.latest {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.nixos.overlays.firmwares
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "rockiosk";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
