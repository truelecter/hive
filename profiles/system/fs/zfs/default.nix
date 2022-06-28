{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
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

  networking.hostId = lib.mkDefault (abort "ZFS requires networking.hostId to be set");

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="zfs_member", ATTR{../queue/scheduler}="none"
  '';
}
