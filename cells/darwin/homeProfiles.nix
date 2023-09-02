{
  inputs,
  cell,
}: let
  inherit (inputs.cells) common;
in
  common.lib.importProfiles {
    src = ./homeProfiles;
  }
