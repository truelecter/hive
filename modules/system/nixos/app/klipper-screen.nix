# Tailscale port to darwin
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tl.services.klipper-screen;
  format = pkgs.formats.ini {
    # https://github.com/NixOS/nixpkgs/pull/121613#issuecomment-885241996
    listToValue = l:
      if builtins.length l == 1
      then generators.mkValueStringDefault {} (head l)
      else lib.concatMapStrings (s: "\n  ${generators.mkValueStringDefault {} s}") l;
    mkKeyValue = generators.mkKeyValueDefault {} ":";
  };
in {
  options.tl.services.klipper-screen = {
    enable = mkEnableOption "KlipperScreen, the touchscreen GUI that interfaces with Klipper via Moonraker";

    package = mkOption {
      type = types.package;
      default = pkgs.klipper-screen;
      defaultText = literalExpression "pkgs.klipper-screen";
      description = lib.mdDoc "The KlipperScreen package.";
    };

    user = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        User account under which KlipperScreen runs.
        If null is specified (default), a temporary user will be created by systemd.
      '';
    };

    group = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = lib.mdDoc ''
        Group account under which KlipperScreen runs.
        If null is specified (default), a temporary user will be created by systemd.
      '';
    };

    settings = mkOption {
      type = format.type;
      default = {};
      description = lib.mdDoc ''
        Configuration for KlipperScreen. See the [documentation](https://klipperscreen.readthedocs.io/en/latest/Configuration/)
        for supported values.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.enable -> config.services.moonraker.enable;
        message = "klipper-screen requires Moonraker to be enabled on this system. Please enable services.moonraker to use it.";
      }
      {
        assertion = cfg.user != null -> cfg.group != null;
        message = "Option klipper-screen.group is not set when a user is specified.";
      }
    ];

    systemd.services.klipper-screen = {
      description = "KlipperScreen, the touchscreen GUI that interfaces with Klipper via Moonraker";

      after = ["moonraker.service"];
      wantedBy = ["multi-user.target"];

      path = [
        pkgs.xorg.xorgserver
        pkgs.xorg.xauth
        pkgs.xorg.xinit
        pkgs.nettools
        pkgs.util-linux
      ];

      serviceConfig = {
        ExecStart = "${pkgs.xorg.xinit}/bin/xinit ${cfg.package}/bin/ks-environment --configfile /etc/klipper-screen.cfg -- /etc/X11/xinit/xserverrc";
        SupplementaryGroups = "tty";
        Group = cfg.group;
        User = cfg.user;
      };
    };

    users = {
      users.klipper-screen = {
        isSystemUser = true;

        group =
          if cfg.group != null
          then cfg.group
          else "klipper-screen";

        extraGroups = ["tty"];
      };
      groups.klipper-screen = {};
    };

    environment.etc."klipper-screen.cfg".source = format.generate "klipper-screen.cfg" cfg.settings;
    environment.etc."X11/Xwrapper.config".text = lib.mkDefault ''
      allowed_users=anybody
    '';
  };
}
