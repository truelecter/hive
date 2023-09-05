{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klipper_z_calibration";

  inherit (sources.klipper-z-calibration) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/extras
    cp ./z_calibration.py $out/lib/extras
  '';

  passthru.klipper = {
    config = false;
    extras = true;
  };

  meta = with lib; {
    description = "Klipper plugin for self-calibrating z-offset";
    platforms = platforms.linux;
    homepage = "https://github.com/protoloft/klipper_z_calibration";
    license = licenses.gpl3Only;
  };
}
