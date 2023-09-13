{
  klipperscreen,
  sources,
  ...
}:
klipperscreen.overrideAttrs (_: _: {
  inherit (sources.klipper-screen) version src;
})
