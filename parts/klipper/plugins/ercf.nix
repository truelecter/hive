{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "ercf";

  inherit (sources.klipper-ercf) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/{extras,config}
    cp './Klipper_Files/Extra module/ercf.py' $out/lib/extras
    cp ./Klipper_Files/*.cfg $out/lib/config
  '';

  passthru.klipper = {
    config = true;
    extras = true;
  };

  meta = with lib; {
    description = "Macros and python module for the ERCF V1.1";
    platforms = platforms.linux;
    homepage = "https://github.com/EtteGit/EnragedRabbitProject";
    license = licenses.gpl3Only;
  };
}
