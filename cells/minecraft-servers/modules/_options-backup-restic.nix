{
  pkgs,
  globalOptions,
}: {
  lib,
  config,
  ...
}: let
  l = builtins // lib;
  inherit (lib) types mkOption mkEnableOption;
  filteredOptions = [
    "_module"
    "backupCleanupCommand"
    "backupPrepareCommand"
    "user"
    "paths"
  ];
in {
  options =
    {
      enable = mkEnableOption "Enable restic backup";
    }
    # Take most of the options from restic service options definition
    // l.filterAttrs (n: _: !(l.elem n filteredOptions)) (globalOptions.services.restic.backups.type.getSubOptions []);
}
