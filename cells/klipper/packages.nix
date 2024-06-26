{
  inputs,
  cell,
}: let
  inherit (inputs) nixos;
  inherit (inputs.cells) common;

  nixpkgs = import nixos {inherit (inputs.nixpkgs) system;};
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
    extraArguments =
      {
        inherit cell;
      }
      // packages;
  };

  danger-klipper = packages.klipper.overrideAttrs (_: {
    inherit (sources.danger-klipper) pname version src;
  });

  excluded-plugins-from-full = ["sources"];
in
  packages
  # TODO: prefix plugins with klipper- if the name does not have this prefix
  // klipper-plugins
  // {
    klipper-full-plugins = packages.klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };

    danger-klipper-full-plugins = danger-klipper.override {
      plugins = l.attrValues (l.filterAttrs (n: _: !builtins.elem n excluded-plugins-from-full) klipper-plugins);
    };

    danger-klipper-genconf = packages.klipper-genconf.override {
      klipper = danger-klipper;
    };

    danger-klipper-firmware = packages.klipper-firmware.override {
      klipper = danger-klipper;
    };
  }
