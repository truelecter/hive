{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest nmd self;
  inherit (inputs.cells) home;

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

  hmModules = builtins.attrValues home.homeModules;

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

  hmModulesDocs = nmd.lib.buildModulesDocs {
    modules =
      hmModules
      ++ [
        setupModule
      ];
    moduleRootPaths = [../home/homeModules];
    mkModuleUrl = path: "https://github.com/truelecter/hive/tree/master/cells/home/homeModules/${path}";
    channelName = "hive-tl";
    docBook = {
      id = "tl-hm-options";
      optionIdPrefix = "hm-opt";
    };
  };

  docs = nmd.lib.buildDocBookDocs {
    pathName = "hive-tl";
    modulesDocs = [hmModulesDocs];
    documentsDirectory = ./documents;
    chunkToc = ''
      <toc>
        <d:tocentry xmlns:d="http://docbook.org/ns/docbook" linkend="book-hive-tl-manual"><?dbhtml filename="index.html"?>
          <d:tocentry linkend="ch-hm-options"><?dbhtml filename="hm-options.html"?></d:tocentry>
        </d:tocentry>
      </toc>
    '';
  };
in {
  inherit (docs) html htmlOpenTool;
}
