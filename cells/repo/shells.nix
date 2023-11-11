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
    nvfetcher
    act
    ;

  inherit
    (nixpkgs)
    sops
    editorconfig-checker
    mdbook
    gnupg
    ;

  pkgWithCategory = category: package: {inherit package category;};
  nix = pkgWithCategory "nix";
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";
  infra = pkgWithCategory "infra";
  ci = pkgWithCategory "ci";

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
      fi

      if [ ! -f "$CELL_PATH/sources/nvfetcher.toml" ]; then
        echo "'$CELL' does not appear to have valid sources structure!"
        echo "Sources should be located in 'sources' dir of cell and contain 'nvfetcher.toml' file within it"
        exit 1
      fi

      CELLS=( $CELL_PATH )
    fi

    for C in "''${CELLS[@]}"; do
      if [ -f "$C/sources/nvfetcher.toml" ]; then
        updateCellSources "$C" $@
      else
        echo "'$C/sources/nvfetcher.toml' does not exist. Ignoring..."
      fi
    done

    exit 0
  '';

  sops-reencrypt = nixpkgs.writeScriptBin "sops-reencrypt" ''
    for filename in "$@"
    do
        ${sops}/bin/sops --decrypt --in-place $filename
        ${sops}/bin/sops --encrypt --in-place $filename
    done
  '';

  build-on-target = nixpkgs.writeScriptBin "build-on-target" ''
    set -e -o pipefail

    show_usage() {
      echo "$0 --attr <flake attr to build> --remote <ssh remote address>"
    }

    flakeFlags=(--extra-experimental-features 'nix-command flakes')
    to="$PWD/result"

    while [ "$#" -gt 0 ]; do
      i="$1"; shift 1

      case "$i" in
        --attr)
          attr="$1"
          shift 1
          ;;

        --remote)
          buildHost="$1"
          shift 1
          ;;

        --to)
          to="$1"
          shift 1
          ;;

        *)
          echo "$0: unknown option \`$i'"
          show_help
          exit 1
          ;;
      esac
    done

    # Eval derivation
    echo evaluating...
    drv="$(nix "''${flakeFlags[@]}" eval --raw "''${attr}.drvPath")"

    # Copy derivation to target
    echo copying to target...
    NIX_SSHOPTS=$SSHOPTS nix "''${flakeFlags[@]}" copy --substitute-on-destination --derivation --to "ssh://$buildHost" "$drv"

    # Build derivation on target
    echo build on target...
    ssh $SSHOPTS "$buildHost" sudo -- nix-store --realise "$drv" "''${buildArgs[@]}"

    # Copy result from target
    echo copying from target...
    NIX_SSHOPTS=$SSHOPTS nix copy --no-check-sigs --to "$to" --from "ssh://$buildHost" "$drv"
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
        config.conform
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

      commands = [
        (nix nixUnstable)
        (nix cachix)
        (nix nix-index)
        (nix statix)

        (ci act)

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

        {
          category = "infra";
          name = "sops-reencrypt";
          help = "Reencrypt sops-encrypted files";
          package = sops-reencrypt;
        }

        {
          category = "nix";
          name = "build-on-target";
          help = "Helper script to build derivation on remote host";
          package = build-on-target;
        }

        (linter editorconfig-checker)
        (linter alejandra)

        (docs mdbook)
      ];
    };

    ci = {
      name = "ci";

      packages = [
        update-cell-sources
      ];
    };
  }
