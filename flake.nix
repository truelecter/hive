{
  description = "The Hive - The secretly open NixOS-Society";

  inputs = {
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive?ref=refs/pull/9/head";
      inputs = {
        haumea.follows = "haumea";
        nixos-generators.follows = "nixos-generators";
        colmena.follows = "colmena";
      };
    };
  };

  # tools
  inputs = {
    nix-filter.url = "github:numtide/nix-filter";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix = {
      url = "github:TrueLecter/sops-nix/darwin";
      inputs = {
        nixpkgs.follows = "nixos";
      };
    };
  };

  # nixpkgs & home-manager
  inputs = {
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    k8s.url = "github:nixos/nixpkgs/3005f20ce0aaa58169cdee57c8aa12e5f1b6e1b3";
    nixos.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs.follows = "nixos";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixos";
    };

    home = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = {
    self,
    std,
    nixpkgs,
    hive,
    ...
  } @ inputs:
    hive.growOn {
      inherit inputs;

      nixpkgsConfig = {
        allowUnfree = true;
      };

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      cellsFrom = ./cells;

      cellBlocks = with std.blockTypes;
      with hive.blockTypes; [
        (nixago "config")

        # Modules
        (functions "nixosModules")
        (functions "darwinModules")

        # Profiles
        (functions "commonProfiles")
        (functions "nixosProfiles")
        (functions "darwinProfiles")
        (functions "homeProfiles")
        (functions "userProfiles")
        (functions "users")

        # Suites
        (functions "nixosSuites")
        (functions "darwinSuites")
        (functions "homeSuites")

        (functions "debug")

        (devshells "shells")

        (installables "packages")
        (pkgs "overrides")
        (files "files")
        (functions "overlays")

        colmenaConfigurations
        homeConfigurations
        nixosConfigurations
        darwinConfigurations
      ];
    }
    # soil
    {
      devShells = hive.harvest inputs.self ["repo" "shells"];
      packages = hive.harvest inputs.self [
        ["klipper" "packages"]
        ["common" "packages"]
        ["pam-reattach" "packages"]
        ["rpi" "packages"]
      ];

      nixosModules = hive.pick inputs.self [
        ["tailscale" "nixosModules"]
        ["klipper" "nixosModules"]
        ["k8s" "nixosModules"]
      ];
    }
    {
      colmenaHive = hive.collect self "colmenaConfigurations";
      nixosConfigurations = hive.collect self "nixosConfigurations";
      homeConfigurations = hive.collect self "homeConfigurations";
      darwinConfigurations = hive.collect self "darwinConfigurations";
    }
    {
      darwinConfigurations.squadbook = self.darwinConfigurations.darwin-squadbook;

      debug = hive.harvest inputs.self ["repo" "debug"];
    };
}
