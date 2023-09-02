{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  klipper = common.lib.combineModules {
    src = ./modules;
  };
}
