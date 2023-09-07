{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 1;
      };
      raspberryPi = {
        enable = false;
      };
    };
    consoleLogLevel = 7;
    initrd.availableKernelModules = lib.mkForce [
      "xhci_pci"
      "uas"
      "usbhid"
      "usb_storage"
      "vc4"
      "pcie_brcmstb" # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
    ];
    kernelParams = ["console=ttyS0,115200n8" "console=tty1" "video=DSI-1:800x480@60" "cma=128M"];
  };

  fileSystems = {
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = ["nofail"];
    };
    "/" = {
      device = lib.mkForce "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    raspberry-pi."4" = {
      i2c0.enable = true;
      i2c1.enable = false;
      fkms-3d.enable = true;
    };

    enableRedistributableFirmware = true;
    wirelessRegulatoryDatabase = true;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
}
