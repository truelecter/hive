{
  config,
  pkgs,
  ...
}: let
  wifiInterface = "wifi-ext";
in {
  users.groups.wifi.members = ["truelecter"];

  networking.wireless = {
    enable = true;
    interfaces = [wifiInterface];
    networks."Xata290" = {
      pskRaw = "ext:WIFI_PASSWORD";
      priority = 5;
    };
    networks."Xata290.5" = {
      pskRaw = "ext:WIFI_PASSWORD";
      priority = 10;
    };
    secretsFile = config.sops.secrets.xata-password-env.path;
    extraConfig = ''
      ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wifi
      country=UA
      update_config=1
    '';
  };

  services.udev.extraRules = ''
    ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -KQ -v 0bda -p 1a2b"
  '';

  boot = {
    extraModulePackages = let
      kernel = config.boot.kernelPackages.kernel;

      rtl8852au = pkgs.callPackage ./rtl8852au {
        # Make sure the module targets the same kernel as your system is using.
        inherit kernel;
      };
    in [
      rtl8852au
    ];
  };

  # Disable builtin BT and WIFI
  hardware.deviceTree = {
    overlays = let
      overlay = name: {
        name = name;
        dtboFile = "${pkgs.device-tree_rpi.overlays}/${name}.dtbo";
      };
    in [
      (overlay "disable-bt")
      (overlay "disable-wifi")
    ];
  };
}
