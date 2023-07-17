{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "klipper-ercf";

  inherit (sources.klipper-ercf) version src;

  installPhase = ''
    mkdir -p $out/lib/${pname}/{extras,config}
    cp './Klipper_Files/Extra module/ercf.py' $out/lib/${pname}/extras
    cp ./Klipper_Files/*.cfg $out/lib/${pname}/config
  '';

  meta = with lib; {
    description = "Macros and python module for the ERCF V1.1";
    platforms = platforms.linux;
    homepage = "https://github.com/EtteGit/EnragedRabbitProject";
    license = licenses.gpl3Only;
  };
}
