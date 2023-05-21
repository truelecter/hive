{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea nixos;
  l = nixpkgs.lib // builtins;
in
  haumea.lib.load {
    src = ./profiles;
    # loader = haumea.lib.loaders.path;
    transformer = haumea.lib.transformers.liftDefault;

    inputs = {
      inherit cell inputs;
    };
  }
