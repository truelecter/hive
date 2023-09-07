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
      firmwareConfig = ./firmwares/firmware-config-rpi-4;
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

  users = {
    users.klipper = {
      extraGroups = ["dialout video dma-heap klipper"];
    };
  };

  environment.systemPackages = [
    # pkgs.klipper
    # pkgs.klipper-firmware
    pkgs.klipper-genconf
  ];

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
    };

    host-mcu = {
      enable = false;
      firmware-package = rpiFirmware;
    };
  };

  services.mainsail.enable = true;
}
