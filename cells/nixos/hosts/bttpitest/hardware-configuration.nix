{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  customDtbSource = false;
  # dtbSource = pkgs.bttCb2Dtb;
  # dtbSource = pkgs.bttCb2DtbMainline6_12;
  # dtbSource = pkgs.bttPi2DtbPatched;
  # dtbSource = pkgs.bttCb2DtbRK6_12;

  dtbSource = pkgs.btt-dtb-6_1-rkr5.override {kernel = config.boot.kernelPackages.kernel;};
in {
  boot = {
    # kernelPackages = pkgs.linuxPackages_testing;

    # kernelPackages = pkgs.linuxPackages_6_12;
    # kernelPackages = pkgs.linuxPackages_bttPi2_6_12;
    # kernelPackages = pkgs.linux_6_1_rockchip;
    kernelPackages = pkgs.linuxPackages_bttPi2_rk;
    # extraModulePackages = [
    #   (pkgs.panel-simple-btt.override {kernel = config.boot.kernelPackages.kernel;})
    # ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 100;
        useGenerationDeviceTree = true;
      };
    };
    consoleLogLevel = 8;
    initrd.availableKernelModules = lib.mkForce [
      "xhci_pci"
      "uas"
      "usbhid"
      "usb_storage"
      # "sdhci_pci"
      "mmc_block"

      # "ahci_dwc"
      "phy_rockchip_naneng_combphy"

      # "panfrost"

      # "rockchip_saradc"
      # "rockchip_thermal"
      # "rockchipdrm"
      # "rockchip-rga"
    ];
    kernelParams = [
      "console=ttyS2,1500000n8"
      "console=tty1"
      "video=DSI-1:800x480@60"
    ];
  };

  rockchip.uBoot = pkgs.uBoot_bttPi2;

  fileSystems = {
    "/" = {
      device = lib.mkForce "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  hardware.deviceTree =
    {
      enable = true;

      # dtbSource = "${dbtSource}/dtbs";
      name = "rockchip/rk3566-bigtreetech-cb2.dtb";
      filter = "rk3566-bigtreetech-cb2.dtb";

      overlays = [
        # {
        #   name = "rk3566-dsi";
        #   dtboFile = "${pkgs.bttPi2Dtb}/dtbs/rockchip/overlay/rk3566-dsi.dtbo";
        # }
        # {
        #   name = "enable-dsi1";
        #   dtsFile = ./enable-dsi1.dts;
        # }
        # {
        #   name = "dsi1";
        #   dtsFile = ./dsi1.614.dts;
        # }
        # {
        #   name = "dsi1";
        #   dtsFile = ./dsi1.dts;
        # }
        # {
        #   name = "dsi1-grok";
        #   dtsFile = ./dsi-grok.dts;
        # }
      ];
    }
    // lib.optionalAttrs customDtbSource {
      dtbSource = "${dtbSource}/dtbs";
    };

  system.nixos.tags = [
    "K${config.boot.kernelPackages.kernel.version}"
    "DTB-${
      if customDtbSource
      then dtbSource.name
      else "kernel"
    }"
  ];

  environment.etc."uboot/uboot-rockchip.bin".source = "${pkgs.uBoot_bttPi2}/u-boot-rockchip.bin";

  powerManagement.cpuFreqGovernor = "schedutil";
  # powerManagement.cpuFreqGovernor = "performance";

  systemd.services."irqbalance-oneshot" = {
    enable = true;
    description = "Distribute interrupts after boot using \"irqbalance --oneshot\"";
    documentation = ["man:irqbalance"];
    wantedBy = ["sysinit.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.irqbalance.out}/bin/irqbalance --foreground --oneshot";
    };
  };

  hardware.enableRedistributableFirmware = true;
}
