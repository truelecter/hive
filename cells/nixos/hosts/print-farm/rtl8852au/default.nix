{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  bc,
  nukeReferences,
}:
stdenv.mkDerivation {
  pname = "rtl8852au";
  version = "${kernel.version}-unstable-2024-04-11";

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8852au";
    rev = "865ab0fa91471d595c283d2f3db323f7f15455f5";
    hash = "sha256-c2dpnZS6a0waL1khB9ZEglTwJIBsyRebTMig1B4A0xU=";
  };

  # src = fetchFromGitHub {
  #   owner = "morrownr";
  #   repo = pname;
  #   rev = "1acc7aa085bffec21a91fdc9e293378e06bf25e7";
  #   hash = "sha256-22vzAdzzM5YnfU8kRWSK3HXxw6BA4FOWXLdWEb7T5IE=";
  # };

  nativeBuildInputs = [bc nukeReferences] ++ kernel.moduleBuildDependencies;
  hardeningDisable = ["pic" "format"];

  postPatch = ''
    substituteInPlace ./Makefile \
      --replace-fail /sbin/depmod \# \
      --replace-fail '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/" \
      --replace-fail '/usr/lib/systemd/system-sleep/' "$out/usr/lib/systemd/system-sleep"

    substituteInPlace ./platform/i386_pc.mk \
      --replace-fail /lib/modules "${kernel.dev}/lib/modules"

    cp ${./rpi.mk} ./platform/rpi.mk
    cp ${./platform_ops.c} ./platform/platform_ops.c
  '';

  USER_EXTRA_CFLAGS = "-DCONFIG_PLATFORM_RPI=y";

  makeFlags = [
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "ARCH=${stdenv.hostPlatform.linuxArch}"
    "CONFIG_PLATFORM_I386_PC=n"
    "CONFIG_PLATFORM_ARM_RPI=y"
  ];

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
    mkdir -p "$out/usr/lib/systemd/system-sleep"
  '';

  postInstall = ''
    nuke-refs $out/lib/modules/*/kernel/net/wireless/*.ko
  '';

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Driver for Realtek rtl8852bu and rtl8832bu chipsets, provides the 8852bu mod";
    homepage = "https://github.com/morrownr/rtl8852bu";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}
