{
  config,
  pkgs,
  ...
}: {
  networking.wireless = {
    enable = true;
    # interfaces = [ "wlan0" "wlp1s0u1u2"];
    interfaces = [ "wlp1s0u1u2"];
    networks."Xata291".psk = "@WIFI_PASSWORD@";
    environmentFile = config.sops.secrets.xata-password-env.path;
  };
}
