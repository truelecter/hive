{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  provision = common.lib.combineModules {
    src = ./nixosModules;
  };
}
