{
  config,
  pkgs,
  ...
}: {
  networking.wireless = {
    enable = true;
    interfaces = ["wlan0"];
    networks."Xata290" = {
      psk = "@WIFI_PASSWORD@";
      priority = 5;
    };
    networks."Xata290.5" = {
      psk = "@WIFI_PASSWORD@";
      priority = 10;
    };
    environmentFile = config.sops.secrets.xata-password-env.path;
  };
}
