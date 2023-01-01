{
  lib,
  stdenvNoCC,
  makeWrapper,
  sources,
  inputs,
  python3,
}: let
  reqs = python-packages:
    with python-packages; [
      # direct requirements.txt
      emoji
      pillow
      pysocks
      python-telegram-bot
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

  pythonEnv = python3.withPackages reqs;
in
  stdenvNoCC.mkDerivation {
    pname = "moonraker-telegram-bot";

    inherit (sources.moonraker-telegram-bot) version src;

    nativeBuildInputs = [
      makeWrapper
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/moonraker-telegram-bot
      cp -r ./bot/. $out/lib/moonraker-telegram-bot/

      makeWrapper ${pythonEnv}/bin/python $out/bin/moonraker-telegram-bot \
        --add-flags "$out/lib/moonraker-telegram-bot/main.py"
    '';

    meta = with lib; {
      description = "Telegram bot to interact with Moonraker (Klipper Web API Server)";
      homepage = "https://github.com/nlef/moonraker-telegram-bot/tree/development";
      license = licenses.cc0;
    };
  }
