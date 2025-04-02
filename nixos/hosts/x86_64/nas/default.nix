{
  suites,
  profiles,
  ...
}: {
  imports =
    suites.base
    ++ [
      profiles.common.remote-builder
      profiles.nixos.fs.zfs

      profiles.nixos.containers.docker

      ./hardware-configuration.nix
      ./zfs-mounts.nix
      ./media-server.nix
      ./torrent.nix
      ./samba.nix
      ./video-card.nix
      ./external.nix
      ./postgres.nix
    ];
  #region boot

  # Weird bug with NM-wait-online restart on new configuration always fails
  systemd.services.NetworkManager-wait-online.enable = false;
  # boot.zfs.enableUnstable = lib.mkForce true;
  powerManagement.cpuFreqGovernor = "performance";
  boot.loader = {
    # systemd-boot.enable = false;
    systemd-boot = {
      enable = false;
      consoleMode = "auto";
      editor = false;
      configurationLimit = 1;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    }; # efi
    grub = {
      devices = ["nodev"];
      enable = true;
      efiSupport = true;
      useOSProber = false;
    }; # grub
  }; # bootloader
  #endregion

  networking = {
    networkmanager.enable = false;
    firewall.enable = false;
    hostId = "00000000";
  };

  services.vnstat.enable = true;

  system.stateVersion = "22.05";
}
