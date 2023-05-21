{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tl.services.moonraker-telegram-bot;
  format = pkgs.formats.ini {
    # https://github.com/NixOS/nixpkgs/pull/121613#issuecomment-885241996
    listToValue = l:
      if builtins.length l == 1
      then generators.mkValueStringDefault {} (head l)
      else lib.concatMapStrings (s: "\n  ${generators.mkValueStringDefault {} s}") l;
    mkKeyValue = generators.mkKeyValueDefault {} ":";
  };
in {
  options.tl.services.moonraker-telegram-bot = {
    enable = mkEnableOption "Enable Telegram bot for Moonraker";

    package = mkOption {
      type = types.package;
      description = "Moonraker Telegram bot package to be used in the module";
      default = pkgs.moonraker-telegram-bot;
      defaultText = literalExpression "pkgs.moonraker-telegram-bot";
    };

    user = mkOption {
      type = types.str;
      default = "moonraker-tg-bot";
      description = lib.mdDoc ''
        User account under which moonraker-telegram-bot runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "moonraker-tg-bot";
      description = lib.mdDoc ''
        Group account under which moonraker-telegram-bot runs.
      '';
    };

    server = mkOption {
      type = types.str;
      default = "localhost:7125";
      description = lib.mdDoc ''
        Moonraker server address
      '';
    };

    timelapseDir = mkOption {
      type = types.str;
      default = "/var/lib/moonraker-telegram-bot/timelapse";
      description = lib.mdDoc ''
        Moonraker telegram bot timelapses dir
      '';
    };

    settings = mkOption {
      type = format.type;
      default = {};
      example = {
        secrets = {
          secrets_path = "/etc/moonraker-tg-bot-secrets.conf";
        };
      };
      description = lib.mdDoc ''
        Configuration for Moonraker Telegram bot. See the [documentation](https://github.com/nlef/moonraker-telegram-bot/wiki/Sample-config)
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.etc."moonraker-telegram-bot.conf".source = let
      forcedConfig = {
        bot = {
          server = cfg.server;
        };
        timelapse = {
          basedir = cfg.timelapseDir;
        };
      };
      fullConfig = lib.recursiveUpdate cfg.settings forcedConfig;
    in
      format.generate "moonraker-telegram-bot.conf" fullConfig;

    users = {
      users."${cfg.user}" = {
        isSystemUser = true;
        group = "${cfg.group}";
      };
      groups."${cfg.group}" = {};
    };

    systemd.tmpfiles.rules = [
      "d '${cfg.timelapseDir}' - ${cfg.user} ${cfg.group} - -"
    ];

    # Based on https://github.com/nlef/moonraker-telegram-bot/blob/master/scripts/install.sh#L168
    systemd.services.moonraker-telegram-bot = {
      description = "Starts Moonraker Telegram Bot on startup";

      after = ["network-online.target" "moonraker.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = "${cfg.package}/bin/moonraker-telegram-bot -c /etc/moonraker-telegram-bot.conf";
        Group = cfg.group;
        User = cfg.user;
      };
    };
  };
}
