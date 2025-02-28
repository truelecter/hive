{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  customDtbSource = true;
  dtbSource = pkgs.btt-6_12-dtb.override {kernel = config.boot.kernelPackages.kernel;};
in {
  boot = {
    kernelPackages = pkgs.linuxPackages_bttPi2_6_12;

    extraModulePackages = [
      (pkgs.panel-simple-btt.override {kernel = config.boot.kernelPackages.kernel;})
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 50;
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
    ];
    kernelParams = [
      "console=ttyS2,1500000n8"
      "console=tty1"
      # "video=DSI-1:800x480@56.06"
      # "drm.debug=0x1f"
    ];
  };

  rockchip.uBoot = pkgs.uboot-btt;

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
      name = "rockchip/rk3566-bigtreetech-pi2.dtb";
      filter = "rk3566-bigtreetech-pi2.dtb";

      overlays = [
        {
          name = "opp";
          dtsFile = ./opp.dts;
        }
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

  environment.etc."uboot/uboot-rockchip.bin".source = "${config.rockchip.uBoot}/u-boot-rockchip.bin";

  powerManagement.cpuFreqGovernor = "schedutil";

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
