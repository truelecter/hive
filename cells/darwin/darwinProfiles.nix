{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea darwin;
  l = nixpkgs.lib // builtins;
in
  haumea.lib.load {
    src = ./darwinProfiles;
    # loader = haumea.lib.loaders.path;
    # transformer = haumea.lib.transformers.liftDefault;
    inputs = {
      common = inputs.cells.common.commonProfiles;
      inherit cell inputs;
    };
  }
