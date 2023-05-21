{
  inputs,
  cell,
}: let
  inherit (inputs) haumea nixpkgs;
  l = nixpkgs.lib // builtins;
  cells = inputs.cells;
in
  haumea.lib.load {
    src = ./hosts;
    # loader = haumea.lib.loaders.default;
    transformer = haumea.lib.transformers.liftDefault;
    inputs = {
      inherit inputs;
      lib = l;
      suites = cell.darwinSuites;
      profiles =
        cell.darwinProfiles
        // {
          common = cells.common.commonProfiles;
          secrets = cells.secrets.darwinProfiles.secrets;
          users = cells.home.users.darwin;
        };
      userProfiles = cells.home.userProfiles;
    };
  }
