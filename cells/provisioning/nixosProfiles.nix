{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common nixos;
in
  common.lib.importProfiles {
    src = ./profiles;

    inputs = {
      common = common.commonProfiles;
      nixos = nixos.nixosProfiles;
      inherit cell inputs;
    };
  }
