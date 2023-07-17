{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "klipper-ercf-happy-hare";

  inherit (sources.klipper-ercf-happy-hare) version src;

  installPhase = ''
    mkdir -p $out/lib/${pname}/{extras,config}
    cp ./extras/* $out/lib/${pname}/extras
    cp ./*.cfg $out/lib/${pname}/config
    cp -r ./doc $out/lib/${pname}/doc
  '';

  meta = with lib; {
    description = "New software driver for ERCF control under Klipper";
    platforms = platforms.linux;
    homepage = "https://github.com/moggieuk/ERCF-Software-V3";
    license = licenses.gpl3Only;
  };
}
