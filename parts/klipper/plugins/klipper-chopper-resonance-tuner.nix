{
  lib,
  stdenvNoCC,
  sources,
  gnused,
  chopper-resonance-tuner,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klipper-chopper-resonance-tuner";

  inherit (sources.klipper-chopper-resonance-tuner) version src;

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [gnused];

  installPhase = ''
    mkdir -p $out/lib/config

    cp ./chopper_tune.cfg $out/lib/config

    sed -i '/gcode_shell_command chop_tune/,+4d' $out/lib/config/chopper_tune.cfg

    echo '[gcode_shell_command chop_tune]' >> $out/lib/config/chopper_tune.cfg
    echo 'timeout: 9999.0'                 >> $out/lib/config/chopper_tune.cfg
    echo 'verbose: True'                   >> $out/lib/config/chopper_tune.cfg
    echo 'command: ${chopper-resonance-tuner}/bin/chopper-resonance-tuner' >> $out/lib/config/chopper_tune.cfg
  '';

  passthru.klipper = {
    config = true;
    extras = false;
  };

  meta = with lib; {
    description = "Registers calibration script for TMC drivers";
    platforms = platforms.linux;
    homepage = "https://github.com/MRX8024/chopper-resonance-tuner";
    license = licenses.gpl3Only;
  };
}
