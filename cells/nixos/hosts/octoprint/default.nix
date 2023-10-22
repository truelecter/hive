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
    inputs.cells.secrets.nixosProfiles.wifi

    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./hardware-configuration.nix
    ./wifi.nix
    ./gpio.nix
    ./camera.nix
    ./klipper
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        deviceTree.applyOverlays = prev.callPackage ./apply-overlays-dtmerge.nix {};
        makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});
        # linuxPackages_rpi4 = (import inputs.latest {inherit system;}).linuxPackages_rpi4;
      })
      inputs.cells.klipper.overlays.klipper
    ];
  };

  networking = {
    hostName = "octoprint";
    firewall.enable = false;
  };

  services.vnstat.enable = true;

  system.stateVersion = "22.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };
}
