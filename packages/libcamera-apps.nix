{
  pkgs,
  stdenv,
  lib,
  sources,
  libcamera-rpi,
  boost,
  cmake,
  pkg-config,
  libexif,
  libjpeg,
  libtiff,
  libpng,
  ...
}:
stdenv.mkDerivation rec {
  pname = "libcamera-apps";

  inherit (sources.libcamera-apps) version src;

  buildInputs = [pkg-config];

  nativeBuildInputs = [
    libcamera-rpi
    boost
    libexif
    libjpeg
    libtiff
    libpng
    cmake
  ];

  cmakeFlags = [
    "-DCMAKE_CXX_FLAGS=\"-Wno-error\""
    "-DENABLE_DRM=1"
    "-DENABLE_X11=0"
    "-DENABLE_QT=0"
    "-DENABLE_OPENCV=0"
    "-DENABLE_TFLITE=0"
  ];

  postInstall = ''
    ls -la $out
  '';
}
