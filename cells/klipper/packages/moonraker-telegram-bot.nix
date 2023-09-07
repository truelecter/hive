{
  lib,
  stdenvNoCC,
  makeWrapper,
  sources,
  python39,
  gnused,
  ...
}: let
  reqs = python-packages:
    with python-packages; [
      # direct requirements.txt
      emoji
      pillow
      pysocks
      (
        buildPythonPackage {
          inherit (sources.python-telegram-bot) pname version src;

          doCheck = false;

          propagatedBuildInputs =
            [
              aiolimiter
              apscheduler
              cachetools
              cryptography
              httpx
              pytz
            ]
            ++ httpx.optional-dependencies.socks
            ++ httpx.optional-dependencies.http2;
        }
      )
      # rel
      (
        buildPythonPackage {
          inherit (sources.rel) pname version src;

          doCheck = false;
        }
      )
      requests
      tzlocal
      ujson
      websocket-client
      # wsaccel
      (
        buildPythonPackage {
          inherit (sources.wsaccel) pname version src;
        }
      )

      # From https://github.com/nlef/moonraker-telegram-bot/blob/master/scripts/install.sh#L126
      cryptography
      gevent
      opencv4
    ];

  pythonEnv = python39.withPackages reqs;
in
  stdenvNoCC.mkDerivation {
    pname = "moonraker-telegram-bot";

    inherit (sources.moonraker-telegram-bot) version src;

    buildInputs = [
      gnused
    ];

    nativeBuildInputs = [
      makeWrapper
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/moonraker-telegram-bot
      cp -r ./bot/. $out/lib/moonraker-telegram-bot/

      sed -e 's/^[^#]*cv2.destroyAllWindows()/# &/' -i $out/lib/moonraker-telegram-bot/camera.py

      makeWrapper ${pythonEnv}/bin/python $out/bin/moonraker-telegram-bot \
        --add-flags "$out/lib/moonraker-telegram-bot/main.py"
    '';

    meta = with lib; {
      description = "Telegram bot to interact with Moonraker (Klipper Web API Server)";
      homepage = "https://github.com/nlef/moonraker-telegram-bot/tree/development";
      license = licenses.cc0;
    };
  }
