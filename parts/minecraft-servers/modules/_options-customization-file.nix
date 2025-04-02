{
  instanceName,
  pkgs,
}: {
  name,
  config,
  options,
  lib,
  ...
}: let
  inherit (lib) mkOption types mdDoc mkDefault mkIf mkDerivedConfig;
in {
  options = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = mdDoc ''
        Whether this added to overlay.
      '';
    };

    target = mkOption {
      type = types.str;
      description = mdDoc ''
        Name of symlink. Defaults to the attribute name.
      '';
    };

    text = mkOption {
      default = null;
      type = types.nullOr types.lines;
      description = mdDoc "Text of the file.";
    };

    source = mkOption {
      type = types.path;
      description = mdDoc "Path of the source file.";
    };
  };

  config = {
    target = mkDefault name;
    source = mkIf (config.text != null) (
      mkDerivedConfig options.text (pkgs.writeText "${instanceName}-${builtins.baseNameOf name}")
    );
  };
}
