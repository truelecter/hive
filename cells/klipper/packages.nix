{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  sources = nixpkgs.callPackage ./sources/generated.nix {};

  loadPackages = pkgs: path:
    l.mapAttrs (
      _: v: nixpkgs.callPackage v {inherit sources cell;}
    )
    (
      haumea.lib.load {
        src = path;
        loader = haumea.lib.loaders.path;
      }
    );

  klipper-plugins = loadPackages nixpkgs ./klipper-plugins;
  packages = loadPackages nixpkgs ./packages;

  excluded-plugins-from-full = ["klipper-ercf"];
in
  packages
  // klipper-plugins
  // {
    klipper-full-plugins = packages.klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };
  }
