{
  pkgs,
  lib,
  ...
}: {
  tl.services.klipper-screen = {
    enable = true;
    settings = {
      "printer Trizero" = {
        moonraker_host = "127.0.0.1";
        moonraker_port = 7125;
        extrude_distances = "5, 10, 25, 50";
        extrude_speeds = "1, 2, 5, 25";
      };
    };
  };

  hardware.deviceTree = {
    overlays = let
      overlay = name: {
        name = name;
        dtboFile = "${pkgs.device-tree_rpi.overlays}/${name}.dtbo";
      };
    in [
      (overlay "vc4-kms-v3d-pi4")
      (overlay "vc4-kms-dsi-7inch")
      (overlay "rpi-ft5406")
    ];
  };

  hardware.raspberry-pi."4" = {
    i2c0 = {
      enable = true;
      frequency = 50000;
    };
  };

  services.xserver = {
    enable = true;
    logFile = "/dev/null";

    displayManager = {
      startx.enable = true;
      xserverArgs = ["-keeptty" "-logverbose" "-verbose"];
    };

    excludePackages = with pkgs; [
      xterm
      xdg-utils
      nixos-icons
      xorg.iceauth
    ];
  };
}
