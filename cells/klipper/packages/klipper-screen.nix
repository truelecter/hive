{
  klipperscreen,
  sources,
  ...
}:
klipperscreen.overrideAttrs (_: prev: {
  inherit (sources.klipper-screen) version src;

  preFixup = ''
    ${prev.preFixup}

    cp ${./_files/camera_cfg.py} $out/dist/panels/camera_cfg.py
  '';
})
