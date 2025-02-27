{
  linuxPackages,
  kernel ? linuxPackages.kernel,
  ...
}:
kernel.stdenv.mkDerivation {
  pname = "btt-cb2-dtb-6.1-rkr5";

  inherit (kernel) version src;

  nativeBuildInputs = kernel.nativeBuildInputs;
  buildInputs = kernel.buildInputs;

  buildPhase = ''
    cp ${kernel.configfile} .config

    cp -r ${./_dt/6.1-rkr5}/* .

    echo 'dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-cb2.dtb' > arch/arm64/boot/dts/rockchip/Makefile

    # Speed up buil by not building other DTBs
    echo 'subdir-y += rockchip' > arch/arm64/boot/dts/Makefile

    make dtbs "DTC_FLAGS=-@"
  '';

  installPhase = ''
    mkdir -p $out/dtbs

    INSTALL_DTBS_PATH=$out/dtbs make dtbs_install
  '';
}
