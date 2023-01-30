{
  config,
  pkgs,
  ...
}: {
  networking.wireless = {
    enable = true;
    interfaces = ["wlan0"];
    networks."Xata290.5".psk = "@WIFI_PASSWORD@";
    environmentFile = config.sops.secrets.xata-password-env.path;
  };
}
