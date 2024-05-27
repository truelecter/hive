# Creds to https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/servers/klipper/klipper-firmware.nix#L57
{
  stdenv,
  lib,
  pkg-config,
  pkgsCross,
  bintools-unwrapped,
  libffi,
  libusb1,
  wxGTK32,
  python3,
  gcc-arm-embedded-11,
  klipper,
  avrdude,
  stm32flash,
  firmwareConfig ? null,
  mcu ? "mcu",
  ...
}:
stdenv.mkDerivation rec {
  name = "klipper-firmware-${mcu}-${version}";
  version = klipper.version;
  src = klipper.src;

  nativeBuildInputs = [
    python3
    pkgsCross.avr.stdenv.cc
    gcc-arm-embedded-11
    bintools-unwrapped
    libffi
    libusb1
    avrdude
    stm32flash
    pkg-config
    # wxGTK32 # Required for bossac
  ];

  preBuild = "cp ${firmwareConfig} ./.config";

  postPatch = ''
    patchShebangs .
  '';

  makeFlags = [
    "V=1"
    "KCONFIG_CONFIG=${firmwareConfig}"
    "WXVERSION=3.2"
  ];

  installPhase = ''
    mkdir -p $out
    cp ./.config $out/config
    ls -la out/
    cp out/klipper.bin $out/ || true
    cp out/klipper.uf2 $out/ || true
  '';

  strictDeps = true;
  disallowedReferences = [
    gcc-arm-embedded-11
  ];

  dontFixup = true;

  meta = with lib; {
    inherit (klipper.meta) homepage license;
    description = "Firmware part of Klipper";
    platforms = platforms.linux;
  };
}
