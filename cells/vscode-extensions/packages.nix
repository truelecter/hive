{
  inputs,
  cell,
}: let
  inherit (inputs) latest;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  sources = let
    f = import ./sources/generated.nix;
  in
    f (builtins.intersectAttrs (builtins.functionArgs f) nixpkgs);

  buildVscodeExtension = name': value': let
    fullname = l.removePrefix "\"" (l.removeSuffix "\"" name');
    parts = l.splitString "." fullname;
    publisher = builtins.elemAt parts 0;
    name = builtins.elemAt parts 1;
  in {
    "${publisher}"."${name}" = nixpkgs.vscode-utils.extensionFromVscodeMarketplace {
      inherit publisher name;
      inherit (value') version;
      sha256 = value'.src.outputHash;
    };
  };
in
  builtins.foldl' l.recursiveUpdate {} (l.mapAttrsToList buildVscodeExtension sources)
