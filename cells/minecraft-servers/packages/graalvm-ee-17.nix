{
  stdenv,
  lib,
  sources,
  autoPatchelfHook,
  system,
  #
  alsa-lib,
  fontconfig,
  freetype,
  zlib,
  xorg,
  ...
}: let
  source = sources."graalvm-ee-17-${system}";
in
  stdenv.mkDerivation rec {
    pname = "graalvm-ee-17";

    inherit (source) version src;

    nativeBuildInputs = [autoPatchelfHook];
    buildInputs = [
      alsa-lib # libasound.so wanted by lib/libjsound.so
      fontconfig
      freetype
      stdenv.cc.cc.lib # libstdc++.so.6
      xorg.libX11
      xorg.libXext
      xorg.libXi
      xorg.libXrender
      xorg.libXtst
      zlib
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out
      cp -a $src/. $out/
    '';

    meta = with lib; {
      description = "GraalVM Enterprise Edition";
    };
  }
#

