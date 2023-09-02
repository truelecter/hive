{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in
  common.lib.importProfiles {
    src = ./darwinProfiles;

    inputs = {
      common = common.commonProfiles;
      inherit cell inputs;
    };
  }
