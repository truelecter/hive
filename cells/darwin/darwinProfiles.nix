{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in
  common.lib.importProfiles {
    src = ./profiles;

    inputs = {
      common = common.commonProfiles;
      inherit cell inputs;
    };
  }
