{
  description = "The Hive - The secretly open NixOS-Society";

  # common for deduplication
  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  # hive
  inputs = {
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixago = {
      url = "github:nix-community/nixago";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    std = {
      follows = "hive/std";
    };

    hive = {
      url = "github:divnix/hive";
      inputs = {
        colmena.follows = "colmena";
        nixago.follows = "nixago";
        nixpkgs.follows = "nixpkgs";
      };
    };

    haumea = {
      follows = "hive/std/haumea";
    };
  };

  # tools
  inputs = {
    nix-filter.url = "github:numtide/nix-filter";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    sops-nix = {
      url = "github:TrueLecter/sops-nix/darwin-upstream";
      inputs = {
        nixpkgs.follows = "nixos";
        nixpkgs-stable.follows = "nixos";
      };
    };

    nix-rpi-kernel = {
      url = "github:TrueLecter/nix-rpi-kernel";
    };
  };

  # nixpkgs & home-manager
  inputs = {
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    k8s.url = "github:nixos/nixpkgs/9b5328b7f761a7bbdc0e332ac4cf076a3eedb89b";
    nixos.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.follows = "nixos";
    # nixos.follows = "latest";

    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixos";
    };

    home = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixos";
    };

    home-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "latest";
    };
  };

  # tools
  inputs = {
    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    pyproject-nix = {
      url = "github:nix-community/pyproject.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    std,
    nixpkgs,
    hive,
    ...
  } @ inputs: let
    collect-unrenamed = hive.collect // {renamer = _: target: target;};
    collect-renamed = hive.collect;
  in
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
        (functions "homeModules")

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

        (devshells "shells")

        (functions "lib")

        (files "files")
        (installables "packages")
        (installables "firmwares")
        (pkgs "overrides")
        (functions "overlays")

        colmenaConfigurations
        homeConfigurations
        nixosConfigurations
        darwinConfigurations

        (nixosConfigurations // {name = "provisionConfigurations";})
      ];
    }
    # soil
    {
      devShells = hive.harvest inputs.self ["repo" "shells"];
      packages = hive.harvest inputs.self [
        ["klipper" "packages"]
        ["common" "packages"]
        ["pam-reattach" "packages"]
        ["minecraft-servers" "packages"]
      ];

      nixosModules = hive.pick inputs.self [
        ["klipper" "nixosModules"]
        ["k8s" "nixosModules"]
        ["minecraft-servers" "nixosModules"]
      ];

      homeModules = hive.pick inputs.self [
        ["home" "homeModules"]
      ];
    }
    {
      colmenaHive = collect-unrenamed self "colmenaConfigurations";
      nixosConfigurations = collect-unrenamed self "nixosConfigurations";
      homeConfigurations = collect-unrenamed self "homeConfigurations";
      darwinConfigurations = collect-unrenamed self "darwinConfigurations";
    }
    {
      debug = hive.harvest inputs.self ["repo" "debug"];
    };
}
