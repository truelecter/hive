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
  pythonEnv = python3.withPackages (p:
    with p; [
      plotly
      tqdm
      matplotlib
      numpy
    ]);
  resonanceTuner = writeShellScript "chopper-resonance-tuner" ''
    cd "$( ${coreutils}/bin/dirname "$0" )/../lib/"
    ${pythonEnv}/bin/python3 chopper_plot.py "$@"
  '';
in
  stdenvNoCC.mkDerivation {
    pname = "chopper-resonance-tuner";

    inherit (sources.klipper-chopper-resonance-tuner) version src;

    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [gnused];
    buildInputs = [pythonEnv];

    installPhase = ''
      mkdir -p $out/bin/ $out/lib/

      cp chopper_plot.py $out/lib/
      chmod +x $out/lib/*.py

      cp ${resonanceTuner} $out/bin/chopper-resonance-tuner
      chmod +x $out/bin/chopper-resonance-tuner

      sed -i '2i import os' $out/lib/chopper_plot.py
      sed -i '0,/RESULTS_FOLDER/ s/RESULTS_FOLDER = .*/RESULTS_FOLDER = os.environ.get("CHOPPER_RESONANCE_TUNER_RESULTS_FOLDER", "\/var\/lib\/klipper\/chopper-resonance-tuner")/' $out/lib/chopper_plot.py
      sed -i 's/DATA_FOLDER = .*/DATA_FOLDER = os.environ.get("CHOPPER_RESONANCE_TUNER_DATA_FOLDER", "\/tmp")/g' $out/lib/chopper_plot.py
    '';

    meta = with lib; {
      description = "Registers calibration script for TMC drivers";
      platforms = platforms.linux;
      homepage = "https://github.com/MRX8024/chopper-resonance-tuner";
      license = licenses.gpl3Only;
    };
  }
