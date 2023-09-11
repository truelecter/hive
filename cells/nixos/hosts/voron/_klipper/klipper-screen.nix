{
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    logFile = "/dev/null";

    displayManager = {
      startx.enable = true;
      xserverArgs = ["-keeptty" "-logverbose" "-verbose"];
      # sessionCommands = ''
      #   ${pkgs.xinput}/bin/xinput set-prop "raspberrypi-ts" "Coordinate Transformation Matrix" -1 0 1 0 -1 1 0 0 1
      # '';
    };

    excludePackages = with pkgs; [
      xterm
      xdg-utils
      nixos-icons
      xorg.iceauth
    ];
  };

  tl.services.klipper-screen = {
    enable = true;
    settings = {
      "printer Voron 2.4" = {
        moonraker_host = "127.0.0.1";
        moonraker_port = 7125;
        extrude_distances = "5, 10, 25, 50";
        extrude_speeds = "1, 2, 5, 25";
      };

      "preheat ABS+" = {
        extruder = 235;
        heater_bed = 95;
        chamber = 40;
      };

      "preheat coPET" = {
        extruder = 245;
        heater_bed = 80;
      };

      "menu __main LEDProfile" = {
        name = "LED";
        icon = "light";
      };

      # TODO: may be custom theme for icons?
      "menu __main LEDProfile Dark" = {
        name = "Dark";
        icon = "avatar-default";
        method = "printer.gcode.script";
        params = ''{"script":"LED_PROFILE_APPLY PROFILE=dark"}'';
      };

      "menu __main LEDProfile Full" = {
        name = "Full";
        icon = "light";
        method = "printer.gcode.script";
        params = ''{"script":"LED_PROFILE_APPLY PROFILE=full"}'';
      };

      "menu __main LEDProfile Toolhead" = {
        name = "Toolhead";
        icon = "extruder";
        method = "printer.gcode.script";
        params = ''{"script":"LED_PROFILE_APPLY PROFILE=toolhead"}'';
      };
    };
  };

  # environment.systemPackages = [pkgs.gnome.adwaita-icon-theme];

  hardware.deviceTree = {
    overlays = let
      overlay = name: {
        name = name;
        dtboFile = "${pkgs.device-tree_rpi.overlays}/${name}.dtbo";
      };
    in [
      (overlay "disable-bt")
      (overlay "vc4-kms-v3d-pi4")
      (overlay "vc4-kms-dsi-7inch")
      # replace with vc4-kms-dsi-waveshare-panel when kernel is updated
      (overlay "rpi-ft5406")
    ];
  };

  hardware.raspberry-pi."4" = {
    i2c0 = {
      enable = true;
      frequency = 50000;
    };
  };
}
