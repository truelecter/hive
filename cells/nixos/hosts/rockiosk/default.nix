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
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
