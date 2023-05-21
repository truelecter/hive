{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
in
  haumea.lib.load {
    src = ./nixosModules;
    loader = haumea.lib.loaders.path;
  }
