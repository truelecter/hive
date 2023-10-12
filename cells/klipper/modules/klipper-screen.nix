{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.tl.services.klipper-screen;
  format = pkgs.formats.ini {
    # https://github.com/NixOS/nixpkgs/pull/121613#issuecomment-885241996
    listToValue = l:
      if builtins.length l == 1
      then lib.generators.mkValueStringDefault {} (lib.head l)
      else lib.concatMapStrings (s: "\n  ${lib.generators.mkValueStringDefault {} s}") l;
    mkKeyValue = lib.generators.mkKeyValueDefault {} ":";
  };

  inherit (lib) mkEnableOption mkOption types;
in {
  options.tl.services.klipper-screen = {
    enable = mkEnableOption "KlipperScreen, the touchscreen GUI that interfaces with Klipper via Moonraker";

    package = mkOption {
      type = types.package;
      default = pkgs.klipper-screen;
      defaultText = lib.literalExpression "pkgs.klipper-screen";
      description = lib.mdDoc "The KlipperScreen package.";
    };

    user = mkOption {
      type = types.str;
      default = "klipper-screen";
      description = lib.mdDoc ''
        User account under which KlipperScreen runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "klipper-screen";
      description = lib.mdDoc ''
        Group account under which KlipperScreen runs.
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

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          {
            assertion = cfg.enable -> config.services.moonraker.enable;
            message = "klipper-screen requires Moonraker to be enabled on this system. Please enable services.moonraker to use it.";
          }
        ];

        users = {
          users.${cfg.user} = {
            isSystemUser = true;
            group = cfg.group;
            extraGroups = ["tty"];
          };
          groups.${cfg.group} = {};
        };

        environment.etc."klipper-screen.cfg".source = format.generate "klipper-screen.cfg" cfg.settings;
      }
      (
        # x-server
        lib.mkIf config.services.xserver.enable {
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
              ExecStart = "${pkgs.xorg.xinit}/bin/xinit ${cfg.package}/bin/KlipperScreen --configfile /etc/klipper-screen.cfg -- /etc/X11/xinit/xserverrc";
              SupplementaryGroups = "tty";
              Group = cfg.group;
              User = cfg.user;
            };
          };

          environment.etc."X11/Xwrapper.config".text = lib.mkDefault ''
            allowed_users=anybody
          '';
        }
      )
      (
        # wayland kiosk
        lib.mkIf (!config.services.xserver.enable) {
          services.cage = {
            enable = true;
            user = cfg.user;
            environment = {
              GDK_BACKEND = "wayland";
            };
            extraArguments = ["-d"];
            program = "${cfg.package}/bin/KlipperScreen --configfile /etc/klipper-screen.cfg";
          };
        }
      )
    ]
  );
}
