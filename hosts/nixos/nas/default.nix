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
      profiles.fs.zfs
      profiles.docker
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
      ./zfs-mounts.nix
      ./media-server.nix
      ./torrent.nix
      ./samba.nix
      # ./video.nix
    ];

  #region boot

  # Weird bug with NM-wait-online restart on new configuration always fails
  systemd.services.NetworkManager-wait-online.enable = false;
  # boot.zfs.enableUnstable = lib.mkForce true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    }; # efi
    grub = {
      devices = ["nodev"];
      enable = true;
      efiSupport = true;
      version = 2;
      useOSProber = true;
    }; # grub
  }; # bootloader
  #endregion

  networking = {
    hostName = "nas";
    networkmanager.enable = true;
    firewall.enable = false;
    hostId = "00000000";
  };

  services.vnstat.enable = true;

  system.stateVersion = "22.05";

  # for remote builds
  users.users.root = {
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./../../../secrets/sops/ssh/root_nas.pub)
    ];
  };
}
