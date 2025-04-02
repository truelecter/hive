{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klipper-led_effect";

  inherit (sources.klipper-led_effect) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/extras
    cp ./src/led_effect.py $out/lib/extras
  '';

  passthru.klipper = {
    config = false;
    extras = true;
  };

  meta = with lib; {
    description = "LED effects plugin for klipper";
    platforms = platforms.linux;
    homepage = "https://github.com/julianschill/klipper-led_effect";
    license = licenses.gpl3Only;
  };
}
