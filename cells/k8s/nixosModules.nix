{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  k8s = common.lib.combineModules {
    src = ./modules;
  };
}
