{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "klipper-led_effect";

  inherit (sources.klipper-led_effect) version src;

  installPhase = ''
    mkdir -p $out/lib/${pname}/extras
    cp ./src/led_effect.py $out/lib/${pname}/extras
  '';

  meta = with lib; {
    description = "LED effects plugin for klipper";
    platforms = platforms.linux;
    homepage = "https://klipperscreen.readthedocs.io/en/latest/";
    license = licenses.gpl3Only;
  };
}
