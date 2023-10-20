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

  # TODO: make it possible to choose between ant1,ant2 and noant, make PR to nixos-hardware
  hardware = {
    deviceTree = {
      overlays = [
        # Equivalent to dtparam=audio=on
        {
          name = "choose-antenna";
          dtsText = ''
            /dts-v1/;
            /plugin/;
            / {
              compatible = "brcm,bcm2711";
              fragment@0 {
                // Despite this being ant1 instead of ant2,
                // CM4 will use external antenna. This is because
                // ant1 is enabled by default and switching
                // GPIO pins causes it to activate external antenna
                target = <&ant1>;

                __overlay__ {
                  gpios = <7 0>;
                };
              };

              fragment@1 {
                target = <&ant2>;

                __overlay__ {
                  // output-low is still present here
                  gpios = <3 0>;
                };
              };
            };
          '';
        }
      ];
    };
    enableRedistributableFirmware = lib.mkForce false;
    firmware = [pkgs.raspberrypiWirelessFirmware];
  };

  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="UA"
    '';
  };
}
