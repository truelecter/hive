{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;

  inherit
    (inputs.cells.common.overrides)
    alejandra
    nixUnstable
    cachix
    nix-index
    statix
    ;

  inherit
    (nixpkgs)
    sops
    editorconfig-checker
    mdbook
    nvfetcher
    gnupg
    ;

  pkgWithCategory = category: package: {inherit package category;};
  nix = pkgWithCategory "nix";
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";
  infra = pkgWithCategory "infra";

  inherit (cell) config;

  update-cell-sources = nixpkgs.writeScriptBin "update-cell-sources" ''
    function updateCellSources {
      CELL="$1"
      shift
      ${nvfetcher}/bin/nvfetcher -t -o "$CELL/sources/" -c "$CELL/sources/nvfetcher.toml" $@
    }

    export TMPDIR="/tmp"
    CELL="$1"

    shift

    if [ -z "$CELL" ]; then
      echo "Please, provide cell name or ALL to update all possible sources"
      exit 1
    fi

    if [ "$CELL" = "ALL" ]; then
      shopt -s nullglob
      CELLS=($PRJ_ROOT/cells/*/)
      shopt -u nullglob
    else
      CELL_PATH="$PRJ_ROOT/cells/$CELL/"

      if [ ! -d "$CELL_PATH" ]; then
        echo "'$CELL' does not appear to be a cell!"
        exit 1
      fi;

      if [ ! -f "$CELL_PATH/sources/nvfetcher.toml" ]; then
        echo "'$CELL' does not appear to have valid sources structure!"
        echo "Sources should be located in 'sources' dir of cell and contain 'nvfetcher.toml' file within it"
        exit 1
      fi;

      CELLS=( $CELL_PATH )
    fi

    for C in "''${CELLS[@]}"; do
      [ -f "$C/sources/nvfetcher.toml" ] && updateCellSources "$C" $@
    done

  '';
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {
      name = "infra";

      imports = [
        ./_sops.nix
        std.std.devshellProfiles.default
      ];

      nixago = [
        (std.lib.cfg.conform {data = {inherit (inputs) cells;};})
        config.treefmt
        config.editorconfig
        config.githubsettings
        config.lefthook
        # config.mdbook
      ];

      packages = [
        nixUnstable
        gnupg
        update-cell-sources
      ];

      commands =
        [
          (nix nixUnstable)
          (nix cachix)
          (nix nix-index)
          (nix statix)

          (infra sops)
          (infra inputs.colmena.packages.colmena)
          (infra inputs.home.packages.home-manager)
          (infra inputs.nixos-generators.packages.nixos-generate)

          {
            category = "infra";
            name = "update-cell-sources";
            help = "Update cell package sources with nvfetcher";
            package = update-cell-sources;
          }

          (linter editorconfig-checker)
          (linter alejandra)

          (docs mdbook)
        ]
        ++ l.optional (nixpkgs.stdenv.hostPlatform.isLinux && !nixpkgs.stdenv.buildPlatform.isDarwin)
        (infra inputs.nixos-generators.defaultPackage.${nixpkgs.system});
    };

    ci = {
      name = "ci";

      packages = [
        update-cell-sources
      ];
    };
  }
