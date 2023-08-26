{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  minecraft-servers = common.lib.combineModules {
    src = ./modules;
  };
}
