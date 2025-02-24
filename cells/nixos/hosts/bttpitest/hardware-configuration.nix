{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_bttPi2;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 1;
      };
    };
    consoleLogLevel = 8;
    initrd.availableKernelModules = lib.mkForce [
      "xhci_pci"
      "uas"
      "usbhid"
      "usb_storage"
      "sdhci_pci"
      "mmc_block"

      "ahci_dwc"
      "phy_rockchip_naneng_combphy"
    ];
    kernelParams = ["console=ttyS2,1500000n8"];
  };

  rockchip.uBoot = pkgs.uBoot_bttPi2;

  fileSystems = {
    "/" = {
      device = lib.mkForce "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  hardware.deviceTree = {
    enable = true;
    dtbSource = "${pkgs.bttCb2Dtb}/dtbs";
    name = "rockchip/rk3566-bigtreetech-pi2.dtb";
    filter = "rk3566-bigtreetech-pi2.dtb";
  };

  environment.etc."uboot/uboot-rockchip.bin".source = "${pkgs.uBoot_bttPi2}/u-boot-rockchip.bin";

  powerManagement.cpuFreqGovernor = "performance";

  hardware.enableRedistributableFirmware = true;
}
