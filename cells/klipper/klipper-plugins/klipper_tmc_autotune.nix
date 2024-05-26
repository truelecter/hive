{
  lib,
  stdenvNoCC,
  sources,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "klipper_tmc_autotune";

  inherit (sources.klipper_tmc_autotune) version src;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib/extras
    cp autotune_tmc.py $out/lib/extras
    cp motor_constants.py $out/lib/extras
    cp motor_database.cfg $out/lib/extras
  '';

  passthru.klipper = {
    config = false;
    extras = true;
  };

  meta = with lib; {
    description = "TMC stepper driver autotuning Klipper python extra";
    platforms = platforms.linux;
    homepage = "https://github.com/andrewmcgr/klipper_tmc_autotune/tree/main";
    license = licenses.gpl3Only;
  };
}
