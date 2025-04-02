{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "kamp";

  inherit (sources.klipper-kamp) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/config
    cp ./Configuration/*.cfg $out/lib/config
  '';

  passthru.klipper = {
    config = true;
    extras = false;
  };

  meta = with lib; {
    description = "A unique leveling solution for Klipper-enabled 3D printers!";
    platforms = platforms.linux;
    homepage = "https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging";
    license = licenses.gpl3Only;
  };
}
