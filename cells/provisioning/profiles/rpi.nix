_: {
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    "${toString modulesPath}/installer/sd-card/sd-image-aarch64.nix"
  ];

  fileSystems = {
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
      options = lib.mkForce ["defaults"];
    };

    "/" = {
      device = lib.mkForce "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  systemd.tmpfiles.rules = [
    "d /boot/firmware 0755 root root"
  ];

  sdImage = {
    firmwareSize = 100;
    compressImage = false;
  };

  tl.provision.secrets.unencryptedBase = "/boot/firmware/secrets/";

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;

    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="UA"
    '';

    initrd.availableKernelModules = [
      "xhci_hcd"
      "xhci-pci-renesas"
      "xhci_pci"

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
  };

  hardware = {
    enableRedistributableFirmware = true;

    deviceTree.filter = lib.mkDefault "bcm2711-rpi-*.dtb";
  };

  powerManagement.cpuFreqGovernor = "performance";
}
