{
  config,
  pkgs,
  suites,
  profiles,
  ...
}: {
  imports =
    suites.base
    ++ [
      profiles.fs.zfs
      profiles.docker
    ]
    ++ [
      ./hardware-configuration.nix
      ./zfs-mounts.nix
      ./media-server.nix
    ];

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

  networking = {
    hostName = "nas";
    networkmanager.enable = true;
    hostId = "00000000";
  };

  services.vnstat.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "22.05";
}
