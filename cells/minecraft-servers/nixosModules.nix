{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  minecraft = common.lib.combineModules {
    src = ./modules;
  };
}
