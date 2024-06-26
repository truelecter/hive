{
  config,
  pkgs,
  lib,
  ...
}: {
  users.groups.wifi.members = ["klipper-screen" "truelecter"];

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
    extraConfig = ''
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wifi
      country=UA
      update_config=1
    '';
  };

  hardware = {
    enableRedistributableFirmware = lib.mkForce false;
    firmware = [pkgs.raspberrypiWirelessFirmware];
  };

  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="UA"
    '';
  };
}
