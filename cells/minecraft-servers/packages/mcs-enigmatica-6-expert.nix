{
  stdenv,
  lib,
  sources,
  jdk17,
  unzip,
  strip-nondeterminism,
  ...
}: let
  ss = sources.server-starter.src;
in
  stdenv.mkDerivation rec {
    pname = "enigmatica-6-expert";

    inherit (sources.mcs-enigmatica-6-expert) version src;

    nativeBuildInputs = [jdk17 unzip strip-nondeterminism];

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      mkdir -p $out
      unzip $src -d $out
    '';

    installPhase = ''
      cd $out

      java -jar ${ss} install
    '';

    fixupPhase = ''
      rm installer.jar.log
      rm modpack-download.zip
      strip-nondeterminism libraries/net/minecraft/server/*/server*-srg.jar
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-90ffB2yDbPLSKhRCCYP6CNpq36MO6l1ARxHtiT4nVgM=";

    meta = with lib; {
      description = "GraalVM Enterprise Edition";
    };
  }
