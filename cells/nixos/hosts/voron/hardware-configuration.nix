{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Breaks bluetooth
  # imports = [
  #   "${modulesPath}/installer/sd-card/sd-image-aarch64-installer.nix"
  # ];
  # sdImage.compressImage = false;

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      raspberryPi.enable = false;

      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 5;
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
      "console=ttyS0,115200"
      "console=tty1"
      "video=DSI-0:800x480@60"
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

  hardware.deviceTree.filter = "bcm2711-rpi-4-b.dtb";
}
