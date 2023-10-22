{
  config,
  pkgs,
  lib,
  ...
}: let
  klipperCfg = config.services.klipper;
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
    groups.klipper = {};
    users.klipper = {
      isSystemUser = true;
      group = "klipper";
      extraGroups = ["dialout gpio video dma-heap klipper"];
    };
  };

  environment.systemPackages = [
    pkgs.klipper
    pkgs.klipper-firmware
    pkgs.klipper-genconf
  ];

  systemd.tmpfiles.rules = [
    "d ${gcodePath} 775 klipper klipper"
  ];

  environment.etc = builtins.listToAttrs (
    builtins.map (
      path: {
        name = "klipper.d/${builtins.baseNameOf path}";
        value = {
          inherit (klipperCfg) user group;

          source = path;
        };
      }
    )
    (lib.filesystem.listFilesRecursive ./configs/klipper.d)
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

  tl.services.klipper-mcu = {
    firmware-package = rpiFirmware;
    enable = true;
  };

  systemd.services.klipper-mcu.serviceConfig.SupplementaryGroups = ["spi" "gpio"];
}
