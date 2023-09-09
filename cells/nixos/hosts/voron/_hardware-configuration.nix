{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4.extend (lib.const (ksuper: {
      kernel = ksuper.kernel.override {
        autoModules = false;
        structuredExtraConfig = with lib.kernel; {
          CONFIG_USB_XHCI_PCI = yes;
          CONFIG_USB_XHCI_PCI_RENESAS = yes;
        };
      };
    }));
    # kernelPackages = pkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 1;
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
      "usbhid"
      "usb_storage"
      "vc4"
      "pcie_brcmstb" # required for the pcie bus to work
      "reset-raspberrypi" # required for vl805 firmware to load
    ];
    kernelParams = ["console=ttyS0,115200n8" "console=tty1" "video=DSI-1:800x480@60" "cma=448M"];
    # kernelPatches = [
    #   {
    #     name = "xhci";
    #     patch = null;
    #     extraStructuredConfig = {
    #       CONFIG_USB_XHCI_PCI = lib.kernel.yes;
    #       CONFIG_USB_XHCI_PCI_RENESAS = lib.kernel.yes;
    #     };
    #   }
    # ];
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

  # powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    # raspberry-pi."4" = {
    #   i2c0.enable = false;
    #   i2c1.enable = false;
    #   fkms-3d.enable = false;
    #   touch-ft5406.enable = false;
    # };

    enableRedistributableFirmware = true;
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    dtc
  ];

  environment.etc."u-boot-cm4".source = pkgs.ubootRaspberryPi4_64bit.override {
    extraConfig = ''
      #CONFIG_CMD_NVME=y
      #CONFIG_NVME=y
      #CONFIG_NVME_PCI=y
      CONFIG_USB_STORAGE=y
      CONFIG_USB_FUNCTION_MASS_STORAGE=y
      CONFIG_USB_EHCI_HCD=y
      CONFIG_USB_EHCI_GENERIC=y
      CONFIG_USB_OHCI_HCD=y
      CONFIG_USB_XHCI_BRCM=y
    '';
    extraPatches = [
      ./_patches/xhci-uboot.patch
    ];
  };
}
