{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
in {
  klipper = l.attrValues (haumea.lib.load {
    src = ./modules;
    loader = haumea.lib.loaders.path;
  });
}
