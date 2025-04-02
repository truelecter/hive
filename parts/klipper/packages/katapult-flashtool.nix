{
  stdenvNoCC,
  lib,
  python3,
  makeWrapper,
  sources,
  ...
}: let
  inherit (sources) katapult;
in
  stdenvNoCC.mkDerivation rec {
    name = "katapult-flashtool";

    inherit (katapult) version src;

    nativeBuildInputs = [
      makeWrapper
    ];

    buildInputs = [
      (python3.withPackages (p: with p; [pyserial]))
    ];

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/{lib,bin}
      cp scripts/flashtool.py $out/lib/flashtool.py

      makeWrapper $out/lib/flashtool.py $out/bin/katapult-flashtool
    '';

    meta = with lib; {
      license = licenses.gpl3Only;
      homepage = "https://github.com/Arksine/katapult";
      description = "Configurable bootloader for Klipper";
      platforms = platforms.linux;
    };
  }
