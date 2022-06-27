{
  config,
  pkgs,
  ...
}: {
  virtualisation.docker.enable = true;

  security.sudo.wheelNeedsPassword = false;
  services.vnstat.enable = true;

  environment = {
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
  };

  # Set the timezone
  time.timeZone = "Europe/Kiev";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    startWhenNeeded = true;
    kbdInteractiveAuthentication = false;
    permitRootLogin = "no";
  };

  boot = {
    kernelParams = ["nohibernate"];
    zfs = {
      enableUnstable = true;
      forceImportRoot = false;
    };
    supportedFilesystems = ["zfs"];
  };

  services.zfs = {
    # autoSnapshot.enable = true;
    # autoSnapshot.monthly = 1;
    autoScrub.enable = true;
  };

  # networking.hostId = "00000000";

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
  '';
}
