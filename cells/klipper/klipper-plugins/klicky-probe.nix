{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klicky-probe";

  inherit (sources.klipper-klicky-probe) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/config
    cp ./Klipper_macros/*.cfg $out/lib/config
  '';

  passthru.klipper = {
    config = true;
    extras = false;
  };

  meta = with lib; {
    description = "Microswitch probe with magnetic attachement, primarily aimed at CoreXY 3d printers";
    platforms = platforms.linux;
    homepage = "https://github.com/jlas1/Klicky-Probe/";
    license = licenses.gpl3Only;
  };
}
