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

      cp ${./_files/start-forge-before-1.18.sh} start.sh
      chmod +x start.sh

      java -jar ${ss} install
    '';

    fixupPhase = ''
      rm installer.jar.log modpack-download.zip
      strip-nondeterminism libraries/net/minecraft/server/*/server*-srg.jar
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-b7xc6lKWgafmsgSaCCm32FNAd1nWpurEXcgpEwz/KSg=";

    meta = with lib; {
      description = "Enigmatica 6 Expert is a quest-guided progression modpack for Minecraft 1.16.5";
      homepage = "https://www.curseforge.com/minecraft/modpacks/enigmatica6expert";
    };
  }
