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
    ./klipper
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.rpi.overlays.kernel
      inputs.cells.klipper.overlays.klipper
      (
        final: prev: {
          deviceTree =
            prev.deviceTree
            // {
              applyOverlays = final.callPackage ./dtmerge.nix {};
            };
          makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});
        }
      )
    ];
  };

  networking = {
    hostName = "trizero";
    firewall.enable = false;
  };

  system.stateVersion = "24.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };

  nix.settings = {
    keep-outputs = false;
    keep-derivations = false;
    system-features = [];
  };
}
