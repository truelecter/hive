{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
in {
  tailscale = _: {
    imports = l.attrValues (haumea.lib.load {
      src = ./darwinModules;
      loader = haumea.lib.loaders.path;
    });
  };
}
