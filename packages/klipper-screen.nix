{
  lib,
  stdenvNoCC,
  makeWrapper,
  sources,
  inputs,

  wrapGAppsHook,
  gtk3,
  gobject-introspection,
  cairo,
}: let
  pythonEnv = inputs.mach-nix.lib.${stdenvNoCC.system}.mkPython {
    requirements = builtins.readFile "${sources.klipper-screen.src}/scripts/KlipperScreen-requirements.txt";
  };
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
      license = licenses.gpl3Only;
    };
  }
