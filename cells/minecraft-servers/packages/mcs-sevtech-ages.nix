{
  stdenvNoCC,
  lib,
  sources,
  jdk8,
  unzip,
  strip-nondeterminism,
  ...
}: let
  forge-installer = sources.forge-server-14-23-5-2860.src;
in
  stdenvNoCC.mkDerivation rec {
    pname = "sevtech-ages";

    inherit (sources.mcs-sevtech-ages) version src;

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

      java -jar ${forge-installer} --installServer $out
    '';

    fixupPhase = ''
      rm forge-*installer.jar *.log ServerStart.sh ServerStart.bat Install.sh Install.bat
    '';

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-pg7Jtdfi+oNlgioAv1ZHOXqq0ePRv6erKV9kNIQArA0=";

    meta = with lib; {
      description = "SevTech: Ages is a massive modpack packed with content and progression";
      homepage = "https://www.curseforge.com/minecraft/modpacks/sevtech-ages";
    };
  }
