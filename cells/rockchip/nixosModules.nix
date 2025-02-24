{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  rockchip = common.lib.combineModules {
    src = ./nixosModules;
  };
}
