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

    inputs.cells.klipper.nixosModules.klipper

    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./_hardware-configuration.nix
    ./_wifi.nix
    ./_camera.nix
    ./_klipper
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
    hostName = "voron";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };
}
