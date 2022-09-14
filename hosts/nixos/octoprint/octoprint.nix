{
  config,
  pkgs,
  lib,
  ...
}: {
  services.octoprint = {
    enable = false;
    group = "video";
    plugins = plugins:
      with plugins; [
        ender3v2tempfix
        gcodeeditor
        marlingcodedocumentation
        mqtt
        printtimegenius
        psucontrol
        simpleemergencystop
        stlviewer
        themeify
        titlestatus
        octolapse
        octoprint-dashboard
        octoprint-display-layer-progress
      ];
    extraConfig = {
      webcam.ffmpeg = "${pkgs.ffmpeg_5.bin}/bin/ffmpeg";
    };
  };

  security.sudo.extraRules = [
    {
      users = ["octoprint"];
      commands = lib.mkAfter [
        {
          command = "/run/current-system/sw/bin/systemctl restart octoprint.service";
          options = ["NOPASSWD" "SETENV"];
        }
        {
          command = "/run/current-system/sw/bin/reboot";
          options = ["NOPASSWD" "SETENV"];
        }
        {
          command = "/run/current-system/sw/bin/shutdown now";
          options = ["NOPASSWD" "SETENV"];
        }
      ];
    }
  ];
}
