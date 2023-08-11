{
  stdenv,
  lib,
  sources,
  jdk17,
  unzip,
  ...
}: let
  ss = sources.server-starter.src;
in
  stdenv.mkDerivation rec {
    pname = "enigmatica-6-expert";

    inherit (sources.mcs-enigmatica-6-expert) version src;

    nativeBuildInputs = [jdk17 unzip];

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    unpackPhase = ''
      mkdir -p $out
      unzip $src -d $out
    '';

    installPhase = ''
      cd $out

      java -jar ${ss} install

      rm installer.jar.log
      rm modpack-download.zip

      # this is stupid repacking hack to fix whatever causing srg jar
      # to have differeces despite classes inside being identical
      mkdir tmp
      cd tmp
      jar xvf ../libraries/net/minecraft/server/*/server*-srg.jar
      jar cf ../libraries/net/minecraft/server/*/server*-srg.jar *
      cd ..
      rm -rf tmp
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-8Gk/NwUqDr6plEAAyg66ukKdqmrMD/nn0Tc6shlGV8I=";

    meta = with lib; {
      description = "GraalVM Enterprise Edition";
    };
  }
