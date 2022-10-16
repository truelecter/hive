{
  config,
  pkgs,
  lib,
  ...
}: let
  gcodePath = "/var/lib/gcode";
  klipperCfg = config.services.klipper;
  moonrakerCfg = config.services.moonraker;

  rpiFirmware =
    (pkgs.klipper-firmware.override {
      mcu = "rpi";
      firmwareConfig = ./klipper/firmware-config-rpi-4;
    })
    .overrideAttrs (o: rec {
      patches = [
        ./klipper/rpi-fw.patch
      ];

      preBuild = ''
        NIX_CFLAGS_COMPILE="-DNIXOS_GPIO_H_INCLUDE_PATH=\"${pkgs.linuxHeaders}/include/linux/gpio.h\" $NIX_CFLAGS_COMPILE"
        NIX_CFLAGS_COMPILE="-DNIXOS_SCHED_H_INCLUDE_PATH=\"${pkgs.linuxHeaders}/include/linux/sched.h\" $NIX_CFLAGS_COMPILE"
        NIX_CFLAGS_COMPILE="-DNIXOS_SCHED_TYPES_H_INCLUDE_PATH=\"${pkgs.linuxHeaders}/include/linux/sched/types.h\" $NIX_CFLAGS_COMPILE"
      '';

      installPhase = ''
        mkdir -p $out
        cp -r out/klipper.elf $out
      '';
    });
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
    settings = {
      "include /etc/klipper.d/*.cfg" = {};
      virtual_sdcard = {
        path = gcodePath;
      };
    };
  };

  tl.services.mainsail = {
    enable = true;
    nginx.locations."/webcam".proxyPass = "https://octoprint.saga-monitor.ts.net:8888/cam/index.m3u8";
  };

  tl.services.klipper-mcu = {
    firmware-package = rpiFirmware;
    enable = true;
  };

  systemd.services.klipper-mcu.serviceConfig.SupplementaryGroups = ["spi" "gpio"];

  services.nginx.clientMaxBodySize = "1000m";
}
