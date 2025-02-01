_: {config, ...}: {
  users.groups.wifi.members = ["nixos" "truelecter"];

  networking.wireless = {
    enable = config.tl.provision.secrets.secretsPresent;

    networks = {
      "Xata290.5" = {
        pskRaw = "ext:WIFI_PROVISION_PW";
      };

      "Xata290" = {
        pskRaw = "ext:WIFI_PROVISION_PW";
      };

      "last-resort" = {
        pskRaw = "ext:WIFI_PROVISION_PW";
      };
    };

    secretsFile = "${config.tl.provision.secrets.unencryptedBase}/wifi-envs";
    extraConfig = ''
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wifi
      country=US
      update_config=1
    '';
  };
}
