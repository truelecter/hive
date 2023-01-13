final: prev: {
  klipper = prev.klipper.overrideAttrs (o: {
    inherit (prev.sources.klipper) pname version src;

    postInstall = ''
      ln -sf "${final.klipper-led_effect}/lib/klipper-led_effect/led_effect.py" "$out/lib/klipper/extras/led_effect.py"
    '';
  });
}
