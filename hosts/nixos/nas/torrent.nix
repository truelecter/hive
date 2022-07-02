{
  config,
  pkgs,
  suites,
  profiles,
  ...
}: {
  environment.systemPackages = [pkgs.transmissionic-web];

  services.transmission = {
    enable = true;

    group = "share";

    downloadDirPermissions = "755";

    settings = {
      download-dir = "/mnt/public/torrents/downloads";
      incomplete-dir = "/mnt/public/torrents/incompleted";
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist = "*";
      rpc-whitelist-enabled = true;
      rpc-whitelist = "*";
      preallocation = 1;
    };
  };

  systemd.services.transmission.environment.TRANSMISSION_WEB_HOME = pkgs.transmissionic-web;

  # sops.secrets.deluge-auths.owner = "deluge";
}
