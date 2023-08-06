{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
in {
  minecraft = _: {
    imports = l.attrValues (haumea.lib.load {
      src = ./modules;
      loader = haumea.lib.loaders.path;
      inputs = {
        pkgs = inputs.nixpkgs;
      };
    });
  };
}
