{
  inputs,
  suites,
  profiles,
  overlays,
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

    inputs.cells.rockchip.nixosModules.rockchip

    # inputs.nixos-rockchip.nixosModules.sdImageRockchip
    # inputs.nixos-rockchip.nixosModules.dtOverlayPCIeFix

    ./hardware-configuration.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.rockchip.overlays.dtmerge
      inputs.cells.rockchip.overlays.btt-pi-v2-kernel
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  networking = {
    hostName = "rk3566-test";
    firewall.enable = false;
  };

  system.stateVersion = "24.11";
}
