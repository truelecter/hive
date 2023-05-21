{
  inputs,
  cell,
}: let
  inherit (inputs) k8s std haumea;
  l = k8s.lib // builtins;
in {
  k8s = _: {
    imports = l.attrValues (haumea.lib.load {
      src = ./modules;
      loader = haumea.lib.loaders.path;
      inputs = {
        pkgs = inputs.k8s;
      };
    });
  };
}
