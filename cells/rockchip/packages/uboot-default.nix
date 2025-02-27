{
  lib,
  buildUBoot,
  rkbin,
  sources,
  ...
}:
buildUBoot {
  inherit (sources.uboot) src version;

  # extraPatches = [./_patches/bigtreetech-cb2-dts-and-defconfig.patch];
  # defconfig = "bigtreetech-cb2-rk3566_defconfig";

  extraPatches = [./_patches/uboot-bigtreetech-cb2.patch];
  defconfig = "bigtreetech_cb2_defconfig";

  ROCKCHIP_TPL = rkbin + "/bin/rk35/rk3566_ddr_1056MHz_v1.23.bin";
  BL31 = rkbin.BL31_RK3568;

  filesToInstall = ["u-boot-rockchip.bin" "idbloader.img" "u-boot.itb"];

  extraMeta.platforms = ["aarch64-linux"];
}
