{
  lib,
  stdenvNoCC,
  sources,
  python3,
  writeShellScript,
  gnused,
  coreutils,
  ...
}: let
  pythonEnv = python3.withPackages (p: with p; [matplotlib numpy scipy gitpython]);
  shaketune = writeShellScript "klippain-shaketune" ''
    cd "$( ${coreutils}/bin/dirname "$0" )/../lib/"
    ${pythonEnv}/bin/python3 -m src.is_workflow "$@"
  '';
in
  stdenvNoCC.mkDerivation {
    pname = "klippain-shaketune";

    inherit (sources.klipper-klippain-shaketune) version src;

    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [gnused];
    buildInputs = [pythonEnv];

    installPhase = ''
      mkdir -p $out/bin/ $out/lib/

      cp -r ./src $out/lib/
      chmod +x $out/lib/src/*.py

      cp ${shaketune} $out/bin/klippain-shaketune
      chmod +x $out/bin/klippain-shaketune

      sed -i '2i import os' $out/lib/src/is_workflow.py
      sed -i 's/RESULTS_BASE_FOLDER = .*/RESULTS_BASE_FOLDER = Path(os.environ.get("KLIPPAIN_RESULTS_FOLDER", "\/var\/lib\/klipper\/klippain-results"))/g' $out/lib/src/is_workflow.py
      sed -i 's/KLIPPER_FOLDER = .*/KLIPPER_FOLDER = Path(os.environ.get("KLIPPER_DIR"))/g' $out/lib/src/is_workflow.py
    '';

    meta = with lib; {
      description = "Klipper streamlined input shaper workflow and calibration tools";
      platforms = platforms.linux;
      homepage = "https://github.com/Frix-x/klippain-shaketune";
      license = licenses.gpl3Only;
    };
  }
