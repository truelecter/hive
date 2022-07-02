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
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
      ./zfs-mounts.nix
      ./media-server.nix
      ./torrent.nix
    ];

  environment.systemPackages = [pkgs.lm_sensors pkgs.parted];

  #region boot
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
    hostId = "00000000";
  };

  services.vnstat.enable = true;

  networking.firewall = {
    enable = false;

    # always allow traffic from your Tailscale network
    trustedInterfaces = ["tailscale0"];

    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [config.services.tailscale.port];

    # allow you to SSH in over the public internet
    allowedTCPPorts = [22];
  };

  system.stateVersion = "22.05";

  # for remote builds
  users.users.root = {
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./../../../secrets/sops/ssh/root_nas.pub)
    ];
  };
}
