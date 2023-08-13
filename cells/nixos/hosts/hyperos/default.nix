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
    profiles.remote-builds
    profiles.faster-linux

    ./_hardware-configuration.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs.cells.common.overlays; [
      common-packages
      latest-overrides
    ];
  };

  # boot.zfs.enableUnstable = lib.mkForce true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  system.stateVersion = "22.05";
}
