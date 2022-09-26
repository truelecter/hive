{pkgs, ...}: {
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

    extraConfig = ''
      Section "InputClass"
        # Identifier "Waveshare 5 inch touhcscreen"
        Identifier "evdev touchscreen catchall"
        MatchIsTouchscreen "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        Option "InvertX" "true"
        Option "InvertY" "true"
      EndSection
    '';

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
      "printer Ender 3 V2" = {
        moonraker_host = "127.0.0.1";
        moonraker_port = 7125;
      };
    };
  };
}
