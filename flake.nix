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

    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixos";
    sops-nix.inputs.nixpkgs-22_05.follows = "nixos";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixos";

    naersk.url = "github:nmattia/naersk";
    naersk.inputs.nixpkgs.follows = "nixos";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-generators.url = "github:nix-community/nixos-generators";
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
        })

        nur.overlay
        sops-nix.overlay
        nvfetcher.overlay

        (import ./pakages)
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
          imports = [(digga.lib.importExportableModules ./modules/system)];
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
          /*
           set host-specific properties here
           */
          # NixOS = { };
        };
        importables = rec {
          profiles = self.host-profiles;
          suites = with profiles; rec {
            base = [
              core.nixos
              users.truelecter
              users.root
              secrets
            ];
          };
        };
      };

      #region darwin TBD
      # darwin = {
      #   hostDefaults = {
      #     system = "x86_64-darwin";
      #     channelName = "nixpkgs-darwin-stable";
      #     imports = [(digga.lib.importExportableModules ./modules)];
      #     modules = [
      #       {lib.our = self.lib;}
      #       digga.darwinModules.nixConfig
      #       home.darwinModules.home-manager
      #       sops-nix.nixosModules.sops
      #     ];
      #   };

      #   imports = [(digga.lib.importHosts ./hosts/darwin)];
      #   hosts = {
      #     /*
      #      set host-specific properties here
      #      */
      #     # Mac = { };
      #   };
      #   importables = rec {
      #     profiles = self.host-profiles;
      #     suites = with profiles; rec {
      #       base = [
      #         core.darwin
      #         users.darwin
      #       ];
      #     };
      #   };
      # };
      #endregion

      home = {
        imports = [(digga.lib.importExportableModules ./modules/user)];
        modules = [];
        importables = rec {
          profiles = digga.lib.rakeLeaves ./profiles/user;
          suites = with profiles; rec {
            base = [direnv git];
          };
        };
        users = rec {
          primary-user = {suites, ...}: {imports = suites.base;};
          "andrii.panasiuk" = primary-user;
          truelecter = primary-user;
        }; # digga.lib.importers.rakeLeaves ./users/hm;
      };

      devshell = ./shell;

      # TODO: similar to the above note: does it make sense to make all of
      # these users available on all systems?
      homeConfigurations =
        digga.lib.mergeAny
        # (digga.lib.mkHomeConfigurations self.darwinConfigurations)
        {}
        (digga.lib.mkHomeConfigurations self.nixosConfigurations);

      deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations {
        nas = {
          sshUser = "truelecter";
          hostname = "10.0.7.147";
        };
      };
    };
}
