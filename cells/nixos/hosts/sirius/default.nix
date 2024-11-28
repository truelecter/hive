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

    inputs.cells.klipper.nixosModules.klipper
    inputs.cells.secrets.nixosProfiles.wifi

    ./hardware-configuration.nix
    ./wifi.nix
    ./network-switch.nix
    ./spoolman.nix
    ./home-assistant
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.klipper.overlays.klipper
    ];
  };

  networking = {
    hostName = "sirius";
    firewall.enable = false;
  };

  system.stateVersion = "24.11";
}
