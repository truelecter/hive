{
  klipper,
  sources,
  python3,
  cell,
  ...
}:
klipper.overrideAttrs (o: {
  inherit (sources.klipper) pname version src;

  buildInputs = [(python3.withPackages (p: with p; [cffi pyserial greenlet jinja2 markupsafe numpy can setuptools]))];

  postInstall = ''
    ln -sf "${cell.packages.klipper-led_effect}/lib/klipper-led_effect/led_effect.py" "$out/lib/klipper/extras/led_effect.py"
  '';
})
