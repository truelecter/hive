{
  stdenvNoCC,
  lib,
  sources,
  jdk8,
  unzip,
  strip-nondeterminism,
  ...
}: let
  ss = sources.server-starter.src;
in
  stdenvNoCC.mkDerivation rec {
    pname = "enigmatica-6-expert";

    inherit (sources.mcs-enigmatica-6-expert) version src;

    nativeBuildInputs = [jdk8 unzip strip-nondeterminism];

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      mkdir -p $out
      unzip $src -d $out
    '';

    installPhase = ''
      cd $out

      cp ${./_files/start-forge.sh} start.sh
      chmod +x start.sh

      java -jar ${ss} install
    '';

    fixupPhase = ''
      rm installer.jar.log
      rm modpack-download.zip
      strip-nondeterminism libraries/net/minecraft/server/*/server*-srg.jar
      # This will be used later, when mounting overlayfs
      chmod --recursive u+rw $out/*
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-VN4iWVhD4J2xNu1KNS/iMdfPX2j1HB5+xcuoCmZmDKU=";

    meta = with lib; {
      description = "GraalVM Enterprise Edition";
    };
  }
