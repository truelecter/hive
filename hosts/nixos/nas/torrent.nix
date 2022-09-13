{
  config,
  pkgs,
  suites,
  profiles,
  ...
}: {
  services.transmission = {
    enable = true;

    group = "share";

    downloadDirPermissions = "755";

    settings = {
      download-dir = "/mnt/public/";
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist = "*";
      rpc-whitelist-enabled = true;
      rpc-whitelist = "*";
      preallocation = 1;
      incomplete-dir-enabled = false;
    };
  };

  systemd.services.transmission.environment.TRANSMISSION_WEB_HOME = pkgs.transmissionic-web;
}
