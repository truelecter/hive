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
      SupplementaryGroups = "gpio video dma-heap klipper";
      Environment = "PYTHONPATH=${pkgs.python39Packages.libgpiod}";
      BindReadOnlyPaths = "${pkgs.python39Packages.libgpiod}/lib/python3.9:/usr/lib/python3.9:norbind";
    };
  };

  users.users = {
    klipper = {
      isSystemUser = true;
      group = "klipper";
      extraGroups = ["dialout"];
    };
    moonraker.extraGroups = ["gpio" "video" "dma-heap" "klipper" "dialout"];
  };

  users.groups.klipper = {};

  systemd.services.klipper = {
    serviceConfig = {
      ExecStartPost = [
        "${pkgs.coreutils}/bin/sleep 5"
        "+${pkgs.coreutils}/bin/chmod 775 ${klipperCfg.apiSocket}"
      ];
    };
  };

  services.klipper = {
    enable = true;

    # TODO make function to have list of files to combine
    settings =
      lib.recursiveUpdate
      (
        lib.recursiveUpdate
        (builtins.fromTOML (builtins.readFile ./klipper/klipper-btt-skr3.toml))
        (
          lib.recursiveUpdate
          (builtins.fromTOML (builtins.readFile ./klipper/klipper-fluidd.toml))
          (builtins.fromTOML (builtins.readFile ./klipper/macro.toml))
        )
      )
      {
        virtual_sdcard = {
          path = gcodePath;
        };
      };

    firmwares.mcu = {
      enable = true;
      configFile = ./klipper/firmware-config-skr-3-uart;
    };
  };

  services.fluidd = {
    enable = true;
    # nginx.locations."/webcam".proxyPass = "https://octoprint.saga-monitor.ts.net:8888/cam/index.m3u8";
  };

  services.nginx.clientMaxBodySize = "1000m";
}
