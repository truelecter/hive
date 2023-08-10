{
  inputs,
  cell,
}: let
  inherit (inputs) latest nixpkgs;
  inherit (inputs.cells) common;
in
  common.lib.importPackages {
    nixpkgs = import latest {inherit (nixpkgs) system;};
    sources = ./sources/generated.nix;
    packages = ./packages;
  }
