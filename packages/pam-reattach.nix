{
  pkgs,
  stdenv,
  lib,
  sources,
  cmake,
  openpam,
  ...
}:
stdenv.mkDerivation rec {
  pname = "pam-reattach";

  inherit (sources.pam-reattach) version src;

  buildInputs = [openpam];

  nativeBuildInputs = [
    cmake
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
