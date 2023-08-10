{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  lib = nixpkgs.lib // builtins;
  cells = inputs.cells;
in
  cells.common.lib.importSystemConfigurations {
    src = ./hosts;

    inherit inputs lib;
    suites = cell.darwinSuites;
    profiles =
      cell.darwinProfiles
      // {
        common = cells.common.commonProfiles;
        secrets = cells.secrets.darwinProfiles.secrets;
        users = cells.home.users.darwin;
      };
    userProfiles = cells.home.userProfiles;
  }
