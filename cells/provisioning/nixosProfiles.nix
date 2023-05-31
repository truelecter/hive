{
  inputs,
  cell,
}: let
  inherit (inputs) haumea;
in
  haumea.lib.load {
    src = ./profiles;
    # loader = haumea.lib.loaders.path;
    transformer = haumea.lib.transformers.liftDefault;
    inputs = {
      common = inputs.cells.common.commonProfiles;
      nixos = inputs.cells.nixos.nixosProfiles;
      inherit cell inputs;
    };
  }
