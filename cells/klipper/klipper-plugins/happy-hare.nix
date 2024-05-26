{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "happy-hare";

  inherit (sources.klipper-happy-hare) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/
    cp -r ./extras ./config $out/lib
  '';

  passthru.klipper = {
    config = false;
    extras = true;
  };

  meta = with lib; {
    description = "New software driver for ERCF control under Klipper";
    platforms = platforms.linux;
    homepage = "https://github.com/moggieuk/ERCF-Software-V3";
    license = licenses.gpl3Only;
  };
}
