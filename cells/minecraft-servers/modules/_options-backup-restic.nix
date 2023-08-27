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
    "environmentFile"
  ];
in {
  options =
    {
      enable = mkEnableOption "Enable restic backup";

      environmentFile = mkOption {
        type = types.oneOf [(types.listOf types.str) types.str];
        default = [];
        description = lib.mdDoc ''
          File containing the credentials to access the repository, in the
          format of an EnvironmentFile as described by systemd.exec(5)
        '';
      };
    }
    # Take most of the options from restic service options definition
    // l.filterAttrs (n: _: !(l.elem n filteredOptions)) (globalOptions.services.restic.backups.type.getSubOptions []);
}
