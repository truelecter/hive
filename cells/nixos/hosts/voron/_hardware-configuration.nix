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
        configurationLimit = 5;
      };
      raspberryPi = {
        enable = false;
        version = 4;
        firmwareConfig = ''
          dtparam=ant2
        '';
      };
    };
    consoleLogLevel = 7;
    initrd.availableKernelModules = [
      "xhci_hcd"
      "xhci-pci-renesas"

      "usbhid"
      "usb_storage"

      "sdhci_pci"
      "mmc_block"

      "simplefb"
      "pcie-brcmstb"

      "vc4"
      "pcie_brcmstb" # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
    ];
    kernelParams = [
      "console=ttyS0,115200n8"
      "console=tty1"
      "video=DSI-1:800x480@60"
    ];
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
    enableRedistributableFirmware = true;

    deviceTree.filter = "bcm2711-rpi-cm4.dtb";

    raspberry-pi."4".xhci.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    dtc
    pkgs.i2c-tools
  ];

  environment.etc."u-boot-cm4".source = pkgs.ubootRaspberryPi4_64bit.override {
    extraConfig = ''
      CONFIG_USB_STORAGE=y
      CONFIG_USB_XHCI_BRCM=y
    '';
    extraPatches = [
      ./_patches/xhci-uboot.patch
    ];
  };
}
