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

    ./hardware-configuration.nix
    ./kiosk.nix
    ./wifi.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
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
