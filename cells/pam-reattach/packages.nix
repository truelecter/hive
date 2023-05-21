{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  sources = nixpkgs.callPackage ./sources/generated.nix {};
in
  l.mapAttrs (
    _: v: nixpkgs.callPackage v {inherit sources;}
  )
  (
    haumea.lib.load {
      src = ./packages;
      loader = haumea.lib.loaders.path;
    }
  )
