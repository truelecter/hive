{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  inherit (std.lib.dev) mkNixago;
in {
  editorconfig = mkNixago std.lib.cfg.editorconfig {
    data = {
      root = true;
      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
        indent_style = "space";
        indent_size = 2;
      };
      "*.{diff,patch}" = {
        end_of_line = "unset";
        insert_final_newline = "unset";
        trim_trailing_whitespace = "unset";
        indent_size = "unset";
      };
      "*.md" = {
        max_line_length = "off";
        trim_trailing_whitespace = false;
      };
    };
  };

  # Tool Homepage: https://numtide.github.io/treefmt/
  treefmt = mkNixago std.lib.cfg.treefmt {
    packages = [
      inputs.cells.common.overrides.alejandra
      inputs.nixpkgs.nodePackages.prettier
      inputs.nixpkgs.nodePackages.prettier-plugin-toml
      inputs.nixpkgs.shfmt
    ];
    devshell.startup.prettier-plugin-toml = inputs.nixpkgs.lib.stringsWithDeps.noDepEntry ''
      export NODE_PATH=${inputs.nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules:''${NODE_PATH:-}
    '';
    data = {
      global.excludes = ["cells/*/sources/generated.*" "cells/secrets/*"];
      formatter = {
        nix = {
          command = "alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "prettier";
          options = ["--plugin" "prettier-plugin-toml" "--write"];
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
            "*.toml"
          ];
        };
        shell = {
          command = "shfmt";
          options = ["-i" "2" "-s" "-w"];
          includes = ["*.sh"];
        };
      };
    };
  };

  # Tool Homepage: https://github.com/evilmartians/lefthook
  lefthook = mkNixago std.lib.cfg.lefthook {
    data = {
      commit-msg = {
        commands = {
          conform = {
            # allow WIP, fixup!/squash! commits locally
            run = ''
              [[ "$(head -n 1 {1})" =~ ^WIP(:.*)?$|^wip(:.*)?$|fixup\!.*|squash\!.* ]] ||
              conform enforce --commit-msg-file {1}'';
            skip = ["merge" "rebase"];
          };
        };
      };
      pre-commit = {
        skip = [
          {ref = "update_flake_lock_action";}
        ];
        commands = {
          treefmt = {
            run = "treefmt --fail-on-change {staged_files}";
            skip = ["merge" "rebase"];
          };
        };
      };
    };
  };

  # Tool Hompeage: https://github.com/apps/settings
  # Install Setting App in your repo to enable it
  githubsettings = mkNixago std.lib.cfg.githubsettings {
    data = {
      repository = {
        name = "hive";
        inherit (import (inputs.self + /flake.nix)) description;
        # homepage = "CONFIGURE-ME";
        topics = "nix, nixos, hive, flake, flakes, nix-flake, nix-flakes, haumea, colmena, std";
        default_branch = "master";
        allow_squash_merge = true;
        allow_merge_commit = true;
        allow_rebase_merge = false;
        delete_branch_on_merge = true;
        private = false;
        has_issues = false;
        has_projects = false;
        has_wiki = false;
        has_downloads = false;
      };
    };
  };

  conform = mkNixago std.lib.cfg.conform {
    data = {
      inherit (inputs) cells;
      commit = {
        header = {
          length = 89;
          imperative = true;
        };
        body.required = false;
        gpg.required = true;
        maximumOfOneCommit = false;
        conventional = {
          types = [
            "fix"
            "feat"
            "build"
            "chore"
            "ci"
            "docs"
            "style"
            "refactor"
            "test"
          ];
          scopes = [
            "ci"
            "flake"
          ];
          descriptionLength = 72;
        };
      };
    };
  };

  # # Tool Homepage: https://rust-lang.github.io/mdBook/
  # mdbook = std.lib.cfg.mdbook {
  #   # add preprocessor packages here
  #   packages = [
  #     inputs.nixpkgs.mdbook-linkcheck
  #   ];
  #   data = {
  #     # Configuration Reference: https://rust-lang.github.io/mdBook/format/configuration/index.html
  #     book = {
  #       language = "en";
  #       multilingual = false;
  #       title = "CONFIGURE-ME";
  #       src = "docs";
  #     };
  #     build.build-dir = "docs/build";
  #     preprocessor = {};
  #     output = {
  #       html = {};
  #       # Tool Homepage: https://github.com/Michael-F-Bryan/mdbook-linkcheck
  #       linkcheck = {};
  #     };
  #   };
  #   output = "book.toml";
  #   hook.mode = "copy"; # let CI pick it up outside of devshell
  # };
}
