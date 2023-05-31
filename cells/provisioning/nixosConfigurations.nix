{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  cells = inputs.cells;
in
  haumea.lib.load {
    src = ./configurations;
    # loader = haumea.lib.loaders.default;
    transformer = haumea.lib.transformers.liftDefault;
    inputs = {
      inherit inputs;
      lib = l;
      suites = cell.nixosSuites;
      nixosSuites = cells.nixos.nixosSuites;
      profiles =
        cell.nixosProfiles
        // {
          common = cells.common.commonProfiles;
          secrets = cells.secrets.nixosProfiles.secrets;
          users = cells.home.users.nixos;
        };
      userProfiles = cells.home.userProfiles;
    };
  }
