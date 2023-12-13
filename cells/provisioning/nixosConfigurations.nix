{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  lib = nixpkgs.lib // builtins;
  cells = inputs.cells;
in
  cells.common.lib.importSystemConfigurations {
    src = ./configurations;

    inherit inputs lib;
    suites = cell.nixosSuites;
    profiles =
      cell.nixosProfiles
      // {
        common = cells.common.commonProfiles;
        secrets = cells.secrets.nixosProfiles.secrets;
        users = cells.home.users.nixos;
      };
    userProfiles = cells.home.userProfiles;
  }
