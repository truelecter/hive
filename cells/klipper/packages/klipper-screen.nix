{
  lib,
  stdenvNoCC,
  makeWrapper,
  sources,
  wrapGAppsHook,
  gtk3,
  gobject-introspection,
  cairo,
  python3,
  ...
}: let
  reqs = python-packages:
    with python-packages; [
      # direct requirements.txt
      jinja2
      websocket-client
      pygobject3
      pycairo
      netifaces
      requests

      # python-networkmanager with deps
      (
        buildPythonPackage {
          inherit (sources.python-networkmanager) pname version src;

          propagatedBuildInputs = [
            dbus-python
            six
          ];
        }
      )
    ];

  pythonEnv = python3.withPackages reqs;
in
  stdenvNoCC.mkDerivation rec {
    pname = "klipper-screen";

    inherit (sources.klipper-screen) version src;

    buildInputs = [
      gtk3
    ];

    nativeBuildInputs = [
      makeWrapper
      wrapGAppsHook
      gobject-introspection
      cairo
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/klipper-screen
      cp -r ./ $out/lib/klipper-screen

      makeWrapper ${pythonEnv}/bin/python $out/bin/ks-environment \
        --add-flags "$out/lib/klipper-screen/screen.py"
    '';

    meta = with lib; {
      description = "Touchscreen GUI that interfaces with Klipper via Moonraker";
      homepage = "https://klipperscreen.readthedocs.io/en/latest/";
      platforms = platforms.linux;
      license = licenses.gpl3Only;
    };
  }
