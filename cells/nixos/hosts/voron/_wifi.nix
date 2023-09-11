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
    extraConfig = ''
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel
      country=UA
      update_config=1
    '';
  };

  # TODO: make it possible to choose between ant1,ant2 and noant, make PR to nixos-hardware
  # hardware.deviceTree = {
  #   overlays = [
  #     # Equivalent to dtparam=audio=on
  #     {
  #       name = "ant2";
  #       dtsText = ''
  #         /dts-v1/;
  #         /plugin/;
  #         / {
  #           compatible = "brcm,bcm2711";
  #           fragment@0 {
  #             target = <&ant2>;

  #             __overlay__ {
  #               status = "okay";
  #             };
  #           };
  #         };
  #       '';
  #     }
  #   ];
  # };

  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="UA"
    '';
  };
}
