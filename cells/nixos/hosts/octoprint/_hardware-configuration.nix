{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  boot = {
    # kernelPackages = let
    #   crossPkgs = import pkgs.path {
    #     localSystem.system = "x86_64-linux";
    #     crossSystem.system = "aarch64-linux";
    #   };
    # in
    #   crossPkgs.linuxPackages_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 1;
      };
      raspberryPi = {
        enable = false;
        # uboot.enable = true;
        uboot.configurationLimit = 1;
        version = 4;
      };
    };
    consoleLogLevel = 8;
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
    # kernelPatches = [
    #   {
    #     name = "rpi-diff";
    #     patch = null;
    #     extraConfig = ''
    #       CONFIG_AS_VERSION 23400
    #       CONFIG_BINFMT_MISC m
    #       CONFIG_CC_CAN_LINK_STATIC y
    #       CONFIG_CC_VERSION_TEXT "aarch64-linux-gnu-gcc-8 (Ubuntu/Linaro 8.4.0-3ubuntu1) 8.4.0"
    #       CONFIG_CMA_SIZE_MBYTES 5
    #       CONFIG_CONNECTOR m
    #       CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE y
    #       CONFIG_CRYPTO_KPP m
    #       CONFIG_DEBUG_PREEMPT y
    #       CONFIG_DRM_PANEL_ORIENTATION_QUIRKS m
    #       CONFIG_EXT4_USE_FOR_EXT2 y
    #       CONFIG_F2FS_FS y
    #       CONFIG_FB_SYS_COPYAREA m
    #       CONFIG_FB_SYS_FILLRECT m
    #       CONFIG_FB_SYS_FOPS m
    #       CONFIG_FB_SYS_IMAGEBLIT m
    #       CONFIG_GCC_VERSION 80400
    #       CONFIG_IKCONFIG m
    #       CONFIG_IPV6 m
    #       CONFIG_IP_PNP y
    #       CONFIG_IP_PNP_DHCP y
    #       CONFIG_IP_PNP_RARP y
    #       CONFIG_LD_VERSION 23400
    #       CONFIG_LOCALVERSION "-v8"
    #       CONFIG_LOGO y
    #       CONFIG_LOGO_LINUX_CLUT224 y
    #       CONFIG_MODULE_COMPRESS_NONE y
    #       CONFIG_NLS_CODEPAGE_437 y
    #       CONFIG_NR_CPUS 256
    #       CONFIG_OCFS2_DEBUG_MASKLOG y
    #       CONFIG_PREEMPT y
    #       CONFIG_PREEMPTION y
    #       CONFIG_PREEMPT_COUNT y
    #       CONFIG_PREEMPT_RCU y
    #       CONFIG_ROOT_NFS y
    #       CONFIG_RUNTIME_TESTING_MENU y
    #       CONFIG_SQUASHFS_DECOMP_SINGLE y
    #       CONFIG_SQUASHFS_FILE_CACHE y
    #       CONFIG_STANDALONE y
    #       CONFIG_UEVENT_HELPER y
    #       CONFIG_UEVENT_HELPER_PATH ""
    #       CONFIG_UNINLINE_SPIN_UNLOCK y
    #       CONFIG_USB_XHCI_PCI y
    #     '';
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

  powerManagement.cpuFreqGovernor = "performance";

  hardware.raspberry-pi."4" = {
    fkms-3d.enable = true;
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
}
