{
  klipperscreen,
  sources,
  ...
}:
klipperscreen.overrideAttrs (_: prev: {
  inherit (sources.klipper-screen) version src;
})
