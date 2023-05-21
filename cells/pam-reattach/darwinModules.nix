{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
in
  haumea.lib.load {
    src = ./modules;
    # loader = haumea.lib.loaders.path;
    transformer = with haumea.lib.transformers; [
      liftDefault
      (hoistLists "_imports" "imports")
      (hoistAttrs "_options" "options")
    ];
    inputs = {
      inherit cell inputs;
    };
  }
