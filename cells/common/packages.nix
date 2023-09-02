{
  inputs,
  cell,
}: let
  inherit (inputs) latest nixpkgs;
in
  cell.lib.importPackages {
    nixpkgs = import latest {inherit (nixpkgs) system;};
    sources = ./sources/generated.nix;
    packages = ./packages;
  }
