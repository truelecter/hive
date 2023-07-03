{
  inputs,
  cell,
}: let
  inherit (inputs) haumea latest nmd self;
  inherit (inputs.cells) home;

  selectModules = attr:
    l.flatten (
      l.map l.attrValues (
        l.catAttrs attr (l.attrValues inputs.cells)
      )
    );

  nixpkgs = import latest {inherit (inputs.nixpkgs) system;};

  l = inputs.nixpkgs.lib // builtins;

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

  hmModules = selectModules "homeModules";

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

  nixosModules = selectModules "nixosModules";

  nixosModulesDocs = nmd.lib.buildModulesDocs {
    modules =
      nixosModules
      ++ [
        setupModule
      ];
    moduleRootPaths = [../tailscale/nixosModules]; # TOOD: fill this
    mkModuleUrl = path: "https://github.com/truelecter/hive/tree/master/cells/home/homeModules/${path}";
    channelName = "hive-tl";
    docBook = {
      id = "tl-nixos-options";
      optionIdPrefix = "nixos-opt";
    };
  };

  darwinModules = selectModules "darwinModules";

  darwinModulesDocs = nmd.lib.buildModulesDocs {
    modules =
      darwinModules
      ++ [
        setupModule
      ];
    moduleRootPaths = [../tailscale/darwinModules]; # TOOD: fill this automatically
    mkModuleUrl = path: "https://github.com/truelecter/hive/tree/master/cells/home/homeModules/${path}";
    channelName = "hive-tl";
    docBook = {
      id = "tl-darwin-options";
      optionIdPrefix = "darwin-opt";
    };
  };

  docs = nmd.lib.buildDocBookDocs {
    pathName = "hive-tl";
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
