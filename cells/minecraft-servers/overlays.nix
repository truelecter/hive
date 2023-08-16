{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;

  l = builtins // nixpkgs.lib;

  filterPackages = r: _: _: (l.filterAttrs (n: _: !l.isNull (l.match r n)) cell.packages);
in {
  java = filterPackages "jdk-.*";
  minecraft-servers = filterPackages "mcs-.*";
}
