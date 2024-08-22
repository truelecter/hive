{
  klipperscreen,
  python3,
  sources,
  ...
}:
klipperscreen.overrideAttrs (_: prev: {
  inherit (sources.klipper-screen) version src;

  pythonPath = with python3.pkgs; [
    jinja2
    requests

    mpv

    pygobject3
    pycairo
    websocket-client
  ];
})
