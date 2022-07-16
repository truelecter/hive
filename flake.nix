{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    # Track channels with commits tested and built by hydra
    nixos.url = "github:nixos/nixpkgs/nixos-22.05";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";

    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.nixlib.follows = "nixos";
    digga.inputs.home-manager.follows = "home";
    digga.inputs.deploy.follows = "deploy";

    bud.url = "github:divnix/bud";
    bud.inputs.nixpkgs.follows = "nixos";
    bud.inputs.devshell.follows = "digga/devshell";

    home.url = "github:nix-community/home-manager/release-22.05";
    home.inputs.nixpkgs.follows = "nixos";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin-stable";

    deploy.url = "github:serokell/deploy-rs";
    deploy.inputs.nixpkgs.follows = "nixos";

    sops-nix.url = "github:TrueLecter/sops-nix/darwin";
    # sops-nix.url = "path:/Users/andrii.panasiuk/Projects/nixos/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixos";
    sops-nix.inputs.nixpkgs-22_05.follows = "nixos";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixos";

    naersk.url = "github:nmattia/naersk";
    naersk.inputs.nixpkgs.follows = "nixos";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixos";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixos";

    nix-npm-buildpackage.url = "github:serokell/nix-npm-buildpackage";
    nix-npm-buildpackage.inputs.nixpkgs.follows = "nixos";
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
        nvfetcher.overlay

        (import ./packages)
      ];

      host-profiles =
        digga.lib.rakeLeaves ./profiles/system
        // {
          users = digga.lib.rakeLeaves ./users;
        };

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
          ];
        };

        imports = [(digga.lib.importHosts ./hosts/nixos)];
        hosts = {
          # host-specific properties here
          # NixOS = { };
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
          };
        };
      };

      #region darwin
      darwin = {
        hostDefaults = {
          system = "x86_64-darwin";
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
        hosts = {
          # host-specific properties here
          # Mac = { };
        };
        importables = rec {
          profiles = self.host-profiles;
          suites = with profiles; rec {
            base = [
              darwin.core
              darwin.security.pam
              secrets
            ];
            editors = [
              darwin.editors.sublime-text
              darwin.editors.vscode
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
        imports = [(digga.lib.importExportableModules ./modules/user)];
        modules = [];
        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/user;
          suites = with profiles; rec {
            base = [
              # direnv
              git
              shell.zsh
              shell.tmux
            ];
            develop = [
              dev.aws
              dev.k8s
              dev.terraform
            ];
          };
        };
        users = rec {
          primary = {suites, ...}: {imports = suites.base ++ suites.develop;};
          "andrii.panasiuk" = primary;
          truelecter = primary;
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
      };
    };
}
