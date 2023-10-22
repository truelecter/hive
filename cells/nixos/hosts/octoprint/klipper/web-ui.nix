{
  config,
  pkgs,
  lib,
  ...
}: {
  tl.services.mainsail = {
    enable = true;
    nginx.locations."/webcam".proxyPass = "https://octoprint.saga-monitor.ts.net:8888/cam/index.m3u8";
  };

  services.nginx.clientMaxBodySize = "1000m";
}
