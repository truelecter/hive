{
  linuxPackages,
  kernel ? linuxPackages.kernel,
  ...
}:
kernel.stdenv.mkDerivation {
  name = "panel-simple-btt";

  inherit (kernel) version src;

  patches = [
    ./_patches/panel-simple-btt-pitft-6.12.patch
  ];

  kernel = kernel.dev;
  kernelVersion = kernel.modDirVersion;

  modulePath = "drivers/gpu/drm/panel";

  buildPhase = ''
    sourceRoot="$(pwd -P)"

    cd $sourceRoot/$modulePath

    echo 'obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o' > Makefile

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

    # mkdir -p $out/lib/modules/$kernelVersion/drivers/gpu/drm/panel

    # cp panel-simple.ko $out/lib/modules/$kernelVersion/drivers/gpu/drm/panel/panel-simple.ko
  '';
}
# kernel.dev.overrideAttrs (o: {
#   pname = "panel-simple-btt";
#   patches = [
#     ./_patches/panel-simple-btt-pitft-6.12.patch
#   ];
#   buildFlags = [
#     "KBUILD_BUILD_VERSION=1-NixOS"
#     "scripts"
#     "prepare"
#     "modules_prepare"
#     "drivers/gpu/drm/panel/panel-simple.ko"
#   ];
#   # preBuild = ''
#   #   cp ${kernel.configfile} .config
#   # '';
#   # buildPhase = ''
#   #   make prepare
#   #   make modules_prepare
#   #   make drivers/gpu/drm/panel/panel-simple.ko
#   # '';
#   installPhase = ''
#     mkdir -p $out
#     cp drivers/gpu/drm/panel/panel-simple.ko $out/panel-simple.ko
#   '';
# })

