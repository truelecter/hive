{
  config,
  pkgs,
  ...
}: {
  services.zfs = {
    trim.enable = true;
    autoScrub.pools = ["tank"];
  };

  # Fix permissions
  systemd.tmpfiles.rules = [
    "z /mnt/db 775 share share"
    "z /mnt/pv 775 share share"
    "z /mnt/public/media 775 share share"
  ];

  fileSystems = {
    "/mnt/db" = {
      device = "tank/db";
      fsType = "zfs";
    };

    "/mnt/pv" = {
      device = "tank/pv";
      fsType = "zfs";
    };

    "/mnt/public/media" = {
      device = "tank/public/media";
      fsType = "zfs";
    };
  };
}
