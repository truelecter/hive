{
  config,
  pkgs,
  lib,
  ...
}: let
  gcodePath = "/var/lib/gcode";
  klipperCfg = config.services.klipper;
  moonrakerCfg = config.services.moonraker;
in {
  boot.kernelModules = ["gpiod"];

  environment.systemPackages = [
    pkgs.klipper
    pkgs.klipper-firmware
    pkgs.klipper-genconf
  ];

  systemd.tmpfiles.rules = [
    "d ${gcodePath} 775 klipper klipper"
  ];

  services.moonraker = {
    enable = true;
    address = "0.0.0.0";
    allowSystemControl = true;
    user = klipperCfg.user;
    group = klipperCfg.group;

    settings = lib.recursiveUpdate (builtins.fromTOML (builtins.readFile ./klipper/moonraker.toml)) {
      database = {
        database_path = "${moonrakerCfg.stateDir}/database";
      };

      file_manager = {
        config_path = moonrakerCfg.configDir;
      };
    };
  };

  systemd.services.moonraker = {
    serviceConfig = {
      SupplementaryGroups = config.users.users.klipper.extraGroups;
      Environment = "PYTHONPATH=${pkgs.python39Packages.libgpiod}";
      BindReadOnlyPaths = "${pkgs.python39Packages.libgpiod}/lib/python3.9:/usr/lib/python3.9:norbind";
    };
  };

  users = {
    groups.klipper = {};
    users.klipper = {
      isSystemUser = true;
      group = "klipper";
      extraGroups = ["dialout gpio video dma-heap klipper"];
    };
  };

  environment.etc = builtins.listToAttrs (
    builtins.map (
      path: {
        name = "klipper.d/${builtins.baseNameOf path}";
        value = {
          user = klipperCfg.user;
          group = klipperCfg.group;
          source = path;
        };
      }
    )
    (lib.filesystem.listFilesRecursive ./klipper/config.d)
  );

  services.klipper = {
    enable = true;

    user = "klipper";
    group = "klipper";

    # TODO make function to have list of files to combine
    settings ={
      "include /etc/klipper.d/*.cfg" = {};
      virtual_sdcard = {
        path = gcodePath;
      };
    };
  };


  services.mainsail = {
    enable = true;
    # nginx.locations."/webcam".proxyPass = "https://octoprint.saga-monitor.ts.net:8888/cam/index.m3u8";
  };

  services.nginx.clientMaxBodySize = "1000m";
}
