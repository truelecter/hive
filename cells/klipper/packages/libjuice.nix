{
  lib,
  stdenv,
  sources,
  cmake,
  noServer ? true,
  noTests ? true,
  ...
}: let
  inherit (lib) optional;
in
  stdenv.mkDerivation rec {
    pname = "libjuice";

    inherit (sources.libjuice) version src;

    cmakeFlags =
      [
      ]
      ++ optional noServer "-DNO_SERVER=ON"
      ++ optional noTests "-DNO_TESTS=ON";

    nativeBuildInputs = [cmake];

    meta = with lib; {
      description = "JUICE is a UDP Interactive Connectivity Establishment library";
      homepage = "https://github.com/paullouisageneau/libjuice/tree/06bbfe93ab344e95797220d89b55c7204c3ffa9d";
      platforms = platforms.linux;
      license = licenses.gpl3Only;
    };
  }
