{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in {
  tailscale = common.lib.combineModules {
    src = ./darwinModules;
  };
}
