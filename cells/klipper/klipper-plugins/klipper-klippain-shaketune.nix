{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klipper-klippain-shaketune";

  inherit (sources.klipper-klippain-shaketune) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/

    cp -r ./K-ShakeTune $out/lib/config
    chmod +x $out/lib/config/scripts/*.py
  '';

  passthru.klipper = {
    config = true;
    extras = false;
  };

  meta = with lib; {
    description = "Klipper streamlined input shaper workflow and calibration tools";
    platforms = platforms.linux;
    homepage = "https://github.com/Frix-x/klippain-shaketune";
    license = licenses.gpl3Only;
  };
}
