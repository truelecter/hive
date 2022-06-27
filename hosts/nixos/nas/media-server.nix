{
  config,
  pkgs,
  ...
}: {
  services.minidlna = {
    enable = true;
    announceInterval = 60;
    friendlyName = "DLNA";
    mediaDirs = [
      "A,/mnt/public/media/Music/"
      "V,/mnt/public/media/Videos/"
    ];
  };

  services.samba = {
    enable = true;
    enableNmbd = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = Samba Server
      server role = standalone server
      log file = /var/log/samba/smbd.%m
      max log size = 50
      dns proxy = no
      map to guest = Bad User
    '';

    shares = {
      public = {
        path = "/mnt/public";
        browseable = "yes";
        "writable" = "yes";
        "guest ok" = "yes";
        "public" = "yes";
        "force user" = "share";
      };
    };
  };

  users = {
    groups = {
      share = {
        gid = 10000;
      };
    };

    users = {
      share = {
        uid = 10000;
        isNormalUser = false;
        isSystemUser = true;
        group = "share";
      };
    };
  };
}
