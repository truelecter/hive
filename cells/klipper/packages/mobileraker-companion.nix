{
  lib,
  stdenvNoCC,
  makeWrapper,
  sources,
  python3,
  ...
}: let
  reqs = python-packages:
    with python-packages; [
      # direct requirements.txt
      coloredlogs
      websockets
      requests
      pytz
      tzlocal
      pillow
    ];

  pythonEnv = python3.withPackages reqs;
in
  stdenvNoCC.mkDerivation rec {
    pname = "mobileraker-companion";

    inherit (sources.mobileraker-companion) version src;

    nativeBuildInputs = [
      makeWrapper
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/${pname}
      cp -r ./ $out/lib/${pname}

      makeWrapper ${pythonEnv}/bin/python $out/bin/mobileraker-companion \
        --add-flags "$out/lib/${pname}/mobileraker.py"
    '';

    meta = with lib; {
      description = "Companion for mobileraker, enabling push notification.";
      homepage = "https://github.com/Clon1998/mobileraker_companion";
      platforms = platforms.linux;
      license = licenses.mit;
    };
  }
