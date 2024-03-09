{
  config,
  pkgs,
  lib,
  ...
}: let
  klipperCfg = config.tl.services.klipper;
  moonrakerCfg = config.services.moonraker;
  gcodePath = "${moonrakerCfg.stateDir}/gcodes";
  rpiFirmware =
    (pkgs.klipper-firmware.override {
      mcu = "rpi";
      firmwareConfig = ./firmwares/klipper-rpi-4;
    })
    .overrideAttrs (o: {
      patches = [
        ./firmwares/rpi-fw.patch
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

  systemd.tmpfiles.rules = [
    "d ${gcodePath} 775 klipper klipper"
  ];

  environment.etc = builtins.listToAttrs (
    builtins.map (
      p: {
        name = "klipper/${lib.path.removePrefix ./configs/klipper.d p}";
        value = {
          inherit (klipperCfg) user group;

          source = p;
        };
      }
    )
    (lib.filesystem.listFilesRecursive ./configs/klipper.d)
  );

  tl.services.klipper = {
    enable = true;

    package = pkgs.klipper-full-plugins;
    extraConfigurationPackages = [
      pkgs.kamp
    ];

    settings = {
      "include /etc/klipper/main.cfg" = {};

      virtual_sdcard = {
        path = gcodePath;
      };

      "gcode_shell_command shaketune" = {
        command = "${pkgs.klippain-shaketune}/bin/klippain-shaketune";
        timeout = 600.0;
        verbose = true;
      };
    };

    host-mcu = {
      enable = false;
      firmware-package = rpiFirmware;
    };

    firmwares = {
      ebb = {
        enable = true;
        configFile = ./firmwares/klipper-ebb;
      };

      manta = {
        enable = true;
        configFile = ./firmwares/klipper-manta;
      };

      manta-v2 = {
        enable = true;
        configFile = ./firmwares/klipper-manta-v2;
      };

      xiao2040 = {
        enable = true;
        configFile = ./firmwares/klipper-xiao2040;
      };
    };

    katapult = {
      manta = {
        enable = true;
        configFile = ./firmwares/katapult-manta;
      };

      manta-v2 = {
        enable = true;
        configFile = ./firmwares/katapult-manta-v2;
      };

      ebb = {
        enable = true;
        configFile = ./firmwares/katapult-ebb;
      };

      xiao2040 = {
        enable = true;
        configFile = ./firmwares/katapult-xiao2040;
      };
    };
  };

  environment.systemPackages = [pkgs.katapult-flashtool];

  services.mainsail = {
    enable = true;
    nginx.extraConfig = ''
      client_max_body_size 0;
    '';
  };
}
