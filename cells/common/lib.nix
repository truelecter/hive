{
  inputs,
  cell,
}: let
  inherit (inputs) haumea;

  defaultNixpkgs = import inputs.nixpkgs {inherit (inputs.nixpkgs) system;};
in rec {
  importProfiles = {
    inputs ? {},
    src,
  }:
    haumea.lib.load {
      inherit src inputs;

      transformer = haumea.lib.transformers.liftDefault;
    };

  importModules = {src}:
    haumea.lib.load {
      inherit src;
      loader = haumea.lib.loaders.path;
    };

  combineModules = {src}: _: {
    imports = builtins.attrValues (
      importModules {
        inherit src;
      }
    );
  };

  # TODO: pass nixpkgs as well, implicit bee module
  importSystemConfigurations = {
    src,
    suites,
    profiles,
    userProfiles,
    lib,
    inputs,
    overlays ? {},
  }:
    haumea.lib.load {
      inherit src;
      transformer = haumea.lib.transformers.liftDefault;
      inputs = {
        inherit suites profiles userProfiles lib inputs overlays;
      };
    };

  importPackages = {
    nixpkgs ? defaultNixpkgs,
    sources ? null,
    extraArguments ? {},
    packages,
  }: let
    sources' =
      if builtins.isPath sources
      then (nixpkgs.callPackage sources {})
      else sources;
    pkgs =
      nixpkgs.lib.mapAttrs (
        _: v: nixpkgs.callPackage v (extraArguments // {sources = sources';})
      )
      (
        haumea.lib.load {
          src = packages;
          loader = haumea.lib.loaders.path;
        }
      );
  in
    pkgs
    // {
      sources = sources';
    };
}
