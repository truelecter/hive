_: {config, ...}: {
  users.groups.wifi.members = ["nixos" "truelecter"];

  networking.wireless = {
    enable = config.tl.provision.secrets.secretsPresent;

    networks = {
      "@WIFI_PROVISION_SSID@" = {
        psk = "@WIFI_PROVISION_PW@";
      };

      "last-resort" = {
        psk = "@WIFI_PROVISION_PW@";
      };
    };

    environmentFile = "${config.tl.provision.secrets.unencryptedBase}/wifi-envs";
    extraConfig = ''
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wifi
      country=UA
      update_config=1
    '';
  };
}
