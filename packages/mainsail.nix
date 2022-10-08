{ lib, stdenvNoCC, fetchurl, unzip, sources }:

stdenvNoCC.mkDerivation rec {
  pname = "mainsail";

  inherit (sources.mainsail) version src;

  nativeBuildInputs = [ unzip ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = ''
    mkdir mainsail
    unzip $src -d mainsail
  '';

  installPhase = ''
    mkdir -p $out/share/mainsail
    cp -r mainsail $out/share/mainsail/htdocs
  '';

  meta = with lib; {
    description = "Klipper web interface";
    homepage = "https://docs.mainsail.xyz";
    license = licenses.gpl3Only;
  };
}
