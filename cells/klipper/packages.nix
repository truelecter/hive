{
  inputs,
  cell,
}: let
  inherit (inputs) nixos pyproject-nix;
  inherit (inputs.cells) common;

  nixpkgs = import nixos {inherit (inputs.nixpkgs) system;};
  sources = nixpkgs.callPackage ./sources/generated.nix {};

  l = builtins // nixpkgs.lib;

  packages = common.lib.importPackages {
    inherit nixpkgs sources;

    packages = ./packages;
    extraArguments =
      {
        inherit cell pyproject-nix;
      }
      // packages;
  };

  klipper-plugins = common.lib.importPackages {
    inherit nixpkgs sources;

    packages = ./klipper-plugins;
    extraArguments =
      {
        inherit cell;
      }
      // packages;
  };

  klipper-distribution = name: source: let
    klipper = packages.klipper.overrideAttrs (_: {
      inherit (source) pname version src;
    });
  in {
    ${name} = klipper;

    "${name}-full-plugins" = klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };

    "${name}-genconf" = packages.klipper-genconf.override {
      inherit klipper;
    };

    "${name}-firmware" = packages.klipper-firmware.override {
      inherit klipper;
    };
  };

  excluded-plugins-from-full = ["sources"];
in
  packages
  # TODO: prefix plugins with klipper- if the name does not have this prefix
  // klipper-plugins
  // {
    klipper-full-plugins = packages.klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };
  }
  // (
    klipper-distribution "danger-klipper" sources.danger-klipper
  )
  // (
    klipper-distribution "experimental-danger-klipper" sources.experimental-danger-klipper
  )
