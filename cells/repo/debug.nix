{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  sources = nixpkgs.callPackage ./sources/generated.nix {};
in {
  inputs = inputs;
  registry = l.mapAttrs (_: v: {flake = v;}) inputs;
}
