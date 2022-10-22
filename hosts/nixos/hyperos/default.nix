{
  config,
  pkgs,
  suites,
  profiles,
  lib,
  ...
}: {
  imports =
    suites.base
    ++ [
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
    ];

  # boot.zfs.enableUnstable = lib.mkForce true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  system.stateVersion = "22.05";

  # for remote builds
  users.users.root = {
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./../../../secrets/sops/ssh/root_nas.pub)
    ];
  };
}
