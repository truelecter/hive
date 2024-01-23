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
      (
        final: prev: {
          deviceTree =
            prev.deviceTree
            // {
              applyOverlays = final.callPackage ./dtmerge.nix {};
            };
          makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});

          inherit (inputs.nix-rpi-kernel.packages) linuxRpi4Packages raspberrypiWirelessFirmware raspberrypifw;
        }
      )
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "pikiosk";
    firewall.enable = false;
  };

  system.stateVersion = "23.05";
}
