{
  stdenv,
  sources,
  cmake,
  openpam,
  lib,
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

  meta = with lib; {
    description = "Reattach to the user's GUI session on macOS during authentication";
    homepage = "https://github.com/fabianishere/pam_reattach";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
