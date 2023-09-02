{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells) common;
in
  common.lib.importPackages {
    inherit nixpkgs;
    sources = ./sources/generated.nix;
    packages = ./packages;
  }
