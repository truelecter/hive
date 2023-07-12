{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  sources = nixpkgs.callPackage ./sources/generated.nix {};

  loadPackages = path:
    l.mapAttrs (
      _: v: nixpkgs.callPackage v {inherit sources cell;}
    )
    (
      haumea.lib.load {
        src = path;
        loader = haumea.lib.loaders.path;
      }
    );
in
  (loadPackages ./packages)
  // (loadPackages ./klipper-plugins)
  // {
  }
