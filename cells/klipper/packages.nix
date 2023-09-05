{
  inputs,
  cell,
}: let
  inherit (inputs) latest;
  inherit (inputs.cells) common;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};
  sources = nixpkgs.callPackage ./sources/generated.nix {};

  l = builtins // nixpkgs.lib;

  klipper-plugins = common.lib.importPackages {
    inherit nixpkgs sources;

    packages = ./klipper-plugins;
    extraArguments = {
      inherit cell;
    };
  };

  packages = common.lib.importPackages {
    inherit nixpkgs sources;

    packages = ./packages;
    extraArguments = {
      inherit cell;
    };
  };

  excluded-plugins-from-full = ["sources"];
in
  packages
  # TODO: prefix plugins with klipper- if the do not have this prefix
  // klipper-plugins
  // {
    klipper-full-plugins = packages.klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };
  }
