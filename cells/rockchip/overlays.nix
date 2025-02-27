{
  inputs,
  cell,
}: let
  inherit (inputs) nixos-rockchip;

  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };

  master = import inputs.nixpkgs-master {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  packages = _: _: cell.packages;
  # dtmerge = final: prev: {
  #   deviceTree =
  #     prev.deviceTree
  #     // {
  #       applyOverlays = latest.deviceTree.applyOverlays;
  #     };
  # };

  rock-pi-4-kernel = _: _: {
    linuxPackages_rockPi4 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;
    uBoot_rockPi4 = nixos-rockchip.packages.uBootRadxaRock4;
  };

  btt-pi-v2-kernel = final: prev: rec {
    inherit (cell.packages) bttPi2Dtb panel-simple-btt btt-dtb-6_1-rkr5;

    linuxPackages_6_14 = master.linuxPackages_testing;

    linuxPackages_bttPi2_rk = cell.packages.linux-packages-rockchip-btt;
    linuxPackages_bttPi2_6_12 = nixos-rockchip.legacyPackages.kernel_linux_6_12_rockchip;

    uBoot_bttPi2 = cell.packages.uboot-btt;

    bttCb2DtbMainline6_12 = cell.packages.bttCb2Dtb.override {linuxPackages = final.linuxPackages_6_12;};
    bttCb2DtbRK6_12 = cell.packages.bttCb2Dtb.override {linuxPackages = linuxPackages_bttPi2_6_12;};

    deviceTree =
      prev.deviceTree
      // {
        applyOverlays = final.callPackage ./extra/dtmerge.nix {};
      };

    linux_6_1_rockchip = final.linuxKernel.packagesFor (final.linuxKernel.kernels.linux_6_1.override {
      structuredExtraConfig = with final.lib.kernel; {
        ARCH_ROCKCHIP = yes;
        CHARGER_RK817 = yes;
        COMMON_CLK_RK808 = yes;
        COMMON_CLK_ROCKCHIP = yes;
        DRM_ROCKCHIP = yes;
        GPIO_ROCKCHIP = yes;
        MMC_DW = yes;
        MMC_DW_ROCKCHIP = yes;
        MMC_SDHCI_OF_DWCMSHC = yes;
        MOTORCOMM_PHY = yes;
        PCIE_ROCKCHIP_DW_HOST = yes;
        PHY_ROCKCHIP_INNO_CSIDPHY = yes;
        PHY_ROCKCHIP_INNO_DSIDPHY = yes;
        PHY_ROCKCHIP_INNO_USB2 = yes;
        PHY_ROCKCHIP_NANENG_COMBO_PHY = yes;
        PINCTRL_ROCKCHIP = yes;
        PWM_ROCKCHIP = yes;
        REGULATOR_RK808 = yes;
        ROCKCHIP_DW_HDMI = yes;
        ROCKCHIP_IODOMAIN = yes;
        ROCKCHIP_IOMMU = yes;
        ROCKCHIP_MBOX = yes;
        ROCKCHIP_PHY = yes;
        ROCKCHIP_PM_DOMAINS = yes;
        ROCKCHIP_SARADC = yes;
        ROCKCHIP_THERMAL = yes;
        ROCKCHIP_VOP2 = yes;
        RTC_DRV_RK808 = yes;
        SND_SOC_RK817 = yes;
        SND_SOC_ROCKCHIP = yes;
        SND_SOC_ROCKCHIP_I2S_TDM = yes;
        SPI_ROCKCHIP = yes;
        STMMAC_ETH = yes;
        VIDEO_HANTRO_ROCKCHIP = yes;
      };
      kernelPatches = [
        {
          name = "Fix nvme on rk3566";
          patch = ./extra/fix-nvme.patch;
        }
      ];
    });
  };
}
