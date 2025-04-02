{
  stdenvNoCC,
  lib,
  sources,
  jdk17,
  unzip,
  strip-nondeterminism,
  ...
}: let
  forge-installer = sources.forge-server-40-2-9.src;
in
  stdenvNoCC.mkDerivation rec {
    pname = "create-arcane-engineering";

    inherit (sources.mcs-create-arcane-engineering) version src;

    nativeBuildInputs = [jdk17 unzip strip-nondeterminism];

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      mkdir -p $out
      unzip $src -d $out
    '';

    installPhase = ''
      cd $out

      cp ${./_files/start-forge-1.18.sh} start.sh
      chmod +x start.sh

      java -jar ${forge-installer} --installServer $out
    '';

    fixupPhase = ''
      rm *.log run.bat
      strip-nondeterminism libraries/net/minecraft/server/*/server*-srg.jar
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-w0PWwoY/f9ujlWP5Vyc0iG9TmmYQEztbEc3GHwK7UA0=";

    meta = with lib; {
      description = "Embark on an enchanting journey with Create Arcane Engineering, a meticulously crafted collection of both popular and custom mods";
      homepage = "https://www.curseforge.com/minecraft/modpacks/create-arcane-engineering";
    };
  }
