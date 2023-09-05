{
  stdenvNoCC,
  lib,
  sources,
}: let
  srcs = sources."mp-server-pause-forge-1_16_5";
in
  stdenvNoCC.mkDerivation rec {
    pname = "test-plugins";

    inherit (srcs) version src;

    dontUnpack = true;
    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      cp $src $out
    '';

    meta = with lib; {
      description = "Port-knocking server/client.";
    };
  }
