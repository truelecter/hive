{
  inputs,
  cell,
}: let
  inherit (inputs) latest nmd;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  cellsPath = ./..;

  selectModules = attr:
    l.flatten (
      l.map l.attrValues (
        l.catAttrs attr (l.attrValues inputs.cells)
      )
    );

  # Make sure the used package is scrubbed to avoid actually
  # instantiating derivations.
  setupModule = {
    imports = [
      {
        _module.args = {
          pkgs = l.mkForce (nmd.lib.scrubDerivations "pkgs" nixpkgs);
          pkgs_i686 = l.mkForce {};
        };
        _module.check = false;
      }
    ];
  };

  mkModulesDocs = modulesAttr: modulesType: let
    selectedModules = selectModules modulesAttr;
  in
    nmd.lib.buildModulesDocs {
      modules =
        selectedModules
        ++ [
          setupModule
        ];
      moduleRootPaths = [cellsPath];
      mkModuleUrl = path: "https://github.com/truelecter/hive/tree/master/cells/${path}";
      channelName = "hive/cells";
      docBook = {
        id = "tl-${modulesType}-options";
        optionIdPrefix = "${modulesType}-opt";
      };
    };

  hmModulesDocs = mkModulesDocs "homeModules" "hm";
  nixosModulesDocs = mkModulesDocs "nixosModules" "nixos";
  darwinModulesDocs = mkModulesDocs "darwinModules" "darwin";

  docs = nmd.lib.buildDocBookDocs {
    pathName = "hive";
    modulesDocs = [hmModulesDocs nixosModulesDocs darwinModulesDocs];
    documentsDirectory = ./documents;
    chunkToc = ''
      <toc>
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="book-hive-tl-manual"><?dbhtml filename="index.html"?>
          <d:tocentry linkend="ch-hm-options"><?dbhtml filename="hm-options.html"?></d:tocentry>
          <d:tocentry linkend="ch-nixos-options"><?dbhtml filename="nixos-options.html"?></d:tocentry>
          <d:tocentry linkend="ch-darwin-options"><?dbhtml filename="darwin-options.html"?></d:tocentry>
        </d:tocentry>
      </toc>
    '';
  };
in {
  inherit (docs) html htmlOpenTool;
}
