{
  suites,
  profiles,
  inputs,
  ...
}: let
  system = "x86_64-linux";
in {
  _module.specialArgs = {
    inherit inputs;
  };

  imports = [
    suites.base
    profiles.fs.zfs
    profiles.docker
    profiles.common.networking.tailscale
    profiles.remote-builds

    ./hardware-configuration.nix
    ./zfs-mounts.nix
    ./media-server.nix
    ./torrent.nix
    ./samba.nix
    ./video-card.nix
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

  #region boot

  # Weird bug with NM-wait-online restart on new configuration always fails
  systemd.services.NetworkManager-wait-online.enable = false;
  # boot.zfs.enableUnstable = lib.mkForce true;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];
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
      version = 2;
      useOSProber = false;
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
}
