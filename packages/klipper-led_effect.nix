{
  lib,
  stdenvNoCC,
  sources,
}:
stdenvNoCC.mkDerivation rec {
  pname = "klipper-led_effect";

  inherit (sources.klipper-led_effect) version src;

  installPhase = ''
    mkdir -p $out/lib/klipper-led_effect
    cp ./src/led_effect.py $out/lib/klipper-led_effect
  '';

  meta = with lib; {
    description = "LED effects plugin for klipper";
    homepage = "https://klipperscreen.readthedocs.io/en/latest/";
    license = licenses.gpl3Only;
  };
}
