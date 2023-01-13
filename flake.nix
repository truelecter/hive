{
  description = "A highly structured configuration database.";

  inputs = {
    #region Flakes
    k8s.url = "github:nixos/nixpkgs/3933d8bb9120573c0d8d49dc5e890cb211681490";
    nixos.url = "github:nixos/nixpkgs/nixos-22.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    flake-utils.url = "github:numtide/flake-utils";

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixos";
    };

    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus/?ref=refs/pull/120/head";
      inputs.flake-utils.follows = "flake-utils";
    };

    digga = {
      url = "github:divnix/digga";

      inputs = {
        nixpkgs.follows = "nixos";
        nixpkgs-unstable.follows = "latest";
        darwin.follows = "darwin";
        nixlib.follows = "nixos";
        home-manager.follows = "home";
        deploy.follows = "deploy";
        flake-utils-plus.follows = "flake-utils-plus";
        devshell.follows = "devshell";
      };
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    bud = {
      url = "github:divnix/bud";
      inputs = {
        nixpkgs.follows = "nixos";
        devshell.follows = "devshell";
      };
    };

    home = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixos";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin-stable";
    };

    deploy = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixos";
    };

    sops-nix = {
      url = "github:TrueLecter/sops-nix/darwin";
      inputs = {
        nixpkgs.follows = "nixos";
        # nixpkgs-22_05.follows = "nixos";
      };
    };

    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs = {
        nixpkgs.follows = "nixos";
        flake-utils.follows = "flake-utils";
      };
    };

    naersk = {
      url = "github:nmattia/naersk";
      inputs.nixpkgs.follows = "nixos";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      # inputs.nixpkgs.follows = "nixos";
    };

    nixos-generators = {
      url = "github:truelecter/nixos-generators/fix/module-identity-II";
      inputs.nixpkgs.follows = "nixos";
    };

    nix-npm-buildpackage = {
      url = "github:serokell/nix-npm-buildpackage";
      inputs.nixpkgs.follows = "nixos";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs = {
        home-manager.follows = "home";
        nixpkgs.follows = "nixos";
      };
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";

      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixos";
      };
    };

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
    };
    #endregion

    #region Not flakes

    #endregion

    #region nvim plugins
    jabs-nvim = {
      url = "github:matbme/JABS.nvim";
      flake = false;
    };
    #endregion
  };

  outputs = {
    self,
    digga,
    bud,
    nixos,
    home,
    nixos-hardware,
    nur,
    sops-nix,
    nvfetcher,
    deploy,
    nixpkgs,
    nixos-generators,
    latest,
    vscode-server,
    nixos-wsl,
    ...
  } @ inputs:
    digga.lib.mkFlake
    {
      inherit self inputs;

      channelsConfig = {allowUnfree = true;};

      channels = {
        nixos = {
          imports = [(digga.lib.importOverlays ./overlays)];
          overlays = [];
        };
        nixpkgs-darwin-stable = {
          imports = [(digga.lib.importOverlays ./overlays)];
          overlays = [];
        };
        latest = {};
      };

      lib = import ./lib {lib = digga.lib // nixos.lib;};

      sharedOverlays = [
        (final: prev: {
          __dontExport = true;

          lib = prev.lib.extend (lfinal: lprev: {
            our = self.lib;
          });

          inherit inputs;
        })

        nur.overlay
        sops-nix.overlay
        nvfetcher.overlays.default

        (import ./packages)
      ];

      host-profiles =
        digga.lib.rakeLeaves ./profiles/system
        // {
          users = digga.lib.rakeLeaves ./users;
        };

      #region nixos
      nixos = {
        hostDefaults = {
          system = "x86_64-linux";
          channelName = "nixos";
          imports = [
            (digga.lib.importExportableModules ./modules/system/common)
            (digga.lib.importExportableModules ./modules/system/nixos)
          ];
          modules = [
            {lib.our = self.lib;}
            digga.nixosModules.bootstrapIso
            digga.nixosModules.nixConfig
            home.nixosModules.home-manager
            sops-nix.nixosModules.sops
            bud.nixosModules.bud
            vscode-server.nixosModule
          ];
        };

        imports = [(digga.lib.importHosts ./hosts/nixos)];
        hosts = {
          octoprint = {
            system = "aarch64-linux";
            channelName = "nixos";
            modules = [
              nixos-hardware.nixosModules.raspberry-pi-4
            ];
          };
        };
        importables = rec {
          profiles = self.host-profiles;
          suites = with profiles; rec {
            base = [
              profiles.nixos.core
              users.truelecter
              users.root
              secrets
            ];

            remote-dev = [
              users.truelecter-dev
            ];
          };
        };
      };
      #endregion

      #region darwin
      darwin = {
        hostDefaults = {
          system = "aarch64-darwin";
          channelName = "nixpkgs-darwin-stable";
          imports = [
            (digga.lib.importExportableModules ./modules/system/common)
            (digga.lib.importExportableModules ./modules/system/darwin)
          ];
          modules = [
            {lib.our = self.lib;}
            digga.darwinModules.nixConfig
            home.darwinModules.home-manager
            sops-nix.darwinModules.sops
          ];
        };

        imports = [(digga.lib.importHosts ./hosts/darwin)];
        hosts = {};
        importables = rec {
          profiles = self.host-profiles;
          suites = with profiles; rec {
            base = [
              darwin.core
              darwin.security.pam
              darwin.security.one-password
              secrets
              darwin.messengers
            ];
            editors = [
              darwin.editors.sublime-text
            ];
            games = [
              darwin.games.steam
              darwin.games.minecraft
            ];
            system-preferences = [
              darwin.system-preferences.dock
              darwin.system-preferences.finder
              darwin.system-preferences.firewall
              darwin.system-preferences.general
              darwin.system-preferences.keyboard
              darwin.system-preferences.trackpad
            ];
          };
        };
      };
      #endregion

      home = {
        modules = [
          vscode-server.nixosModules.home
        ];
        imports = [
          (digga.lib.importExportableModules ./modules/user)
        ];
        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/user;
          suites = with profiles; {
            base = [
              shell.direnv
              git
              shell.zsh
              profiles.shell.tmux
              shell.nvim
              home-manager-base
            ];
            develop = [
              dev.aws
              dev.k8s
              dev.terraform
              dev.nix
            ];
            develop-gui = [
              dev.vscode
            ];
            darwin = [
              darwin.shell.iterm
              darwin.smart-card-fix
            ];
          };
        };
        users = rec {
          "andrii.panasiuk" = {
            suites,
            profiles,
            ...
          }: {
            imports =
              suites.base
              ++ suites.develop
              ++ suites.develop-gui
              ++ suites.darwin
              ++ [
                profiles.dev.android
              ];
          };
          truelecter = {suites, ...}: {imports = suites.base;};
        }; # digga.lib.importers.rakeLeaves ./users/hm;
      };

      # This is digga option, not Nix's
      devshell = ./shell;

      homeConfigurations =
        digga.lib.mergeAny
        (digga.lib.mkHomeConfigurations self.nixosConfigurations)
        (digga.lib.mkHomeConfigurations self.darwinConfigurations);

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations {
        nas = {
          sshUser = "truelecter";
          hostname = "nas";
        };
        octoprint = {
          sshUser = "truelecter";
          hostname = "octoprint";
        };
        hyperos = {
          sshUser = "truelecter";
        };
        depsos = {
          sshUser = "truelecter";
          sshOpts = ["-p" "2265"];
        };
      };
    };
}
