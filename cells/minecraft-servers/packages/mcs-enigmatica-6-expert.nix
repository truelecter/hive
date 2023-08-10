{
  stdenv,
  lib,
  sources,
  temurin-jre-bin-17,
  unzip,
  ...
}: let
  ss = sources.server-starter.src;
in
  stdenv.mkDerivation rec {
    pname = "enigmatica-6-expert";

    inherit (sources.mcs-enigmatica-6-expert) version src;

    nativeBuildInputs = [temurin-jre-bin-17 unzip];

    dontConfigure = true;
    dontBuild = true;
    dontUnpack = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out
      unzip $src -d $out
      cd $out

      # Temporary accept, so isntaller will pass
      # echo "# EULA" > eula.txt
      # echo "eula = true" >> eula.txt

      java -jar ${ss} install

      rm installer.jar.log
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-eWb8syFDlemSxBjRb2qlD30sy/zEclj0BPCWyXcqXS0=";

    meta = with lib; {
      description = "GraalVM Enterprise Edition";
    };
  }
