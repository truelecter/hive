{linuxPackages, ...}: let
  kernel = linuxPackages.kernel;
in
  kernel.stdenv.mkDerivation {
    pname = "rk3566-bigtreetech-cb2-dtb";

    inherit (kernel) version src;

    nativeBuildInputs = kernel.nativeBuildInputs;
    buildInputs = kernel.buildInputs;

    buildPhase = ''
      cp ${kernel.configfile} .config

      cp ${./_dts}/* arch/arm64/boot/dts/rockchip/

      echo 'dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-cb2-manta.dtb' > arch/arm64/boot/dts/rockchip/Makefile
      echo 'dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-bigtreetech-pi2.dtb' >> arch/arm64/boot/dts/rockchip/Makefile

      # Speed up buil by not building other DTBs
      echo 'subdir-y += rockchip' > arch/arm64/boot/dts/Makefile

      make dtbs
    '';

    installPhase = ''
      mkdir -p $out/dtbs

      INSTALL_DTBS_PATH=$out/dtbs make dtbs_install
    '';
  }
