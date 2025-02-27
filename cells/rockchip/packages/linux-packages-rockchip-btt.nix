{
  linuxPackages_custom,
  sources,
  ...
}:
linuxPackages_custom rec {
  version = "${modDirVersion}-rkr5";
  modDirVersion = "6.1.99";

  inherit (sources.btt-linux-rockchip) src;

  configfile = ./_defconfig/config-6.1.43-bigtree-cb2;
}
