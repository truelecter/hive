{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tl.services.mobileraker-companion;

  format = pkgs.formats.ini {
    # https://github.com/NixOS/nixpkgs/pull/121613#issuecomment-885241996
    listToValue = l:
      if builtins.length l == 1
      then generators.mkValueStringDefault {} (head l)
      else lib.concatMapStrings (s: "\n  ${generators.mkValueStringDefault {} s}") l;
    mkKeyValue = generators.mkKeyValueDefault {} ":";
  };
in {
  options.tl.services.mobileraker-companion = {
    enable = mkEnableOption "Companion for mobileraker, enabling push notification.";

    package = mkOption {
      type = types.package;
      default = pkgs.mobileraker-companion;
      defaultText = literalExpression "pkgs.mobileraker-companion";
      description = lib.mdDoc "The mobileraker-companion package.";
    };

    user = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        User account under which mobileraker-companion runs.
        If null is specified (default), a temporary user will be created by systemd.
      '';
    };

    group = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        Group account under which mobileraker-companion runs.
        If null is specified (default), a temporary user will be created by systemd.
      '';
    };

    settings = mkOption {
      inherit (format) type;
      default = {};
      description = lib.mdDoc ''
        Configuration for mobileraker-companion. See the [documentation](https://github.com/Clon1998/mobileraker_companion#companion---config)
        for supported values.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.enable -> config.services.moonraker.enable;
        message = "mobileraker-companion requires Moonraker to be enabled on this system. Please enable services.moonraker to use it.";
      }
      {
        assertion = cfg.user != null -> cfg.group != null;
        message = "Option mobileraker-companion.group is not set when a user is specified.";
      }
    ];

    systemd.services.mobileraker-companion = {
      description = "Companion for mobileraker, enabling push notification.";

      after = ["moonraker.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/mobileraker-companion --configfile /etc/mobileraker-companion.cfg";
        Group = cfg.group;
        User = cfg.user;
      };
    };

    users = lib.optionalAttrs (cfg.user != null) {
      users.${cfg.user} = {
        isSystemUser = true;

        inherit (cfg) group;

        extraGroups = ["tty"];
      };
      groups.${cfg.group} = {};
    };

    environment.etc."mobileraker-companion.cfg".source = format.generate "mobileraker-companion.cfg" cfg.settings;
  };
}
