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
    pname = "dawncraft";

    inherit (sources.mcs-dawncraft) version src;

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
    outputHash = "sha256-daLgV+ck7+/m4igNakC8Dfycbq5e0RmxvJHeqg6dZ3w=";

    meta = with lib; {
      description = "DawnCraft - An Adventure RPG Modpack";
      homepage = "https://www.curseforge.com/minecraft/modpacks/dawn-craft";
    };
  }
