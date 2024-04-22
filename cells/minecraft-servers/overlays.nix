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
      forge.dynmap-19-2 = sources.mod-forge-19-2-dynmap.src;
      forge.dynmap-blockscan = sources.mod-forge-19-dynmap-blockscan.src;
      forge.bluemap = sources.mod-forge-19-bluemap.src;
      forge.corail-tombstone-19-2 = sources.mod-forge-192-corail-tombstone.src;
      forge.carryon-19-2 = sources.mod-forge-192-carryon.src;
      forge.passablefolliage-19-2 = sources.mod-forge-192-passablefolliage.src;
      forge.kiwi-19-2 = sources.mod-forge-192-kiwi.src;
      forge.ftb-chunks-19-2 = sources.mod-forge-192-ftb-chunks.src;
      forge.ftb-xmod-compat-19-2 = sources.mod-forge-192-ftb-xmod-compat.src;
      sponge.changeskin = sources.mod-sponge-changeskin.src;
      generic.changeskincore = sources.mod-changeskincore.src;
    };
  };
}
