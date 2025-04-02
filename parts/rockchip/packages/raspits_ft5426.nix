{
  linuxPackages,
  kernel ? linuxPackages.kernel,
  ...
}:
kernel.stdenv.mkDerivation {
  name = "raspits_ft5426";

  inherit (kernel) version src;

  patches = [
    ./_patches/raspits_ft5426-6.12.patch
  ];

  kernel = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  modulePath = "drivers/input/touchscreen";

  buildPhase = ''
    sourceRoot="$(pwd -P)"

    cd $sourceRoot/$modulePath

    echo 'obj-$(CONFIG_DRM_PANEL_SIMPLE) += raspits_ft5426.o' > Makefile

    make -C $kernel/lib/modules/$kernelVersion/build modules "M=$(pwd -P)"

    cd $sourceRoot
  '';

  installPhase = ''
    cd $sourceRoot/$modulePath

    make \
      -C $kernel/lib/modules/$kernelVersion/build \
      INSTALL_MOD_PATH="$out" \
      XZ="xz -T$NIX_BUILD_CORES" \
      "M=$(pwd -P)" \
      modules_install
  '';
}
