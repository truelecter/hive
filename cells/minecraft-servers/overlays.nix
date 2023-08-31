{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;

  l = builtins // nixpkgs.lib;

  filterPackages = r: _: _: (l.filterAttrs (n: _: !l.isNull (l.match r n)) cell.packages);

  sources = cell.packages.sources;
in {
  java = filterPackages "jdk-.*";
  minecraft-servers = filterPackages "mcs-.*";
  minecraft-mods = _: _: {
    minecraft-mods = {
      forge.spongeforge = sources.mod-forge-spongeforge.src;
      sponge.changeskin = sources.mod-sponge-changeskin.src;
      generic.changeskincore = sources.mod-changeskincore.src;
    };
  };
}
