{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tl.services.klipper-mcu;
  cfgKlipper = config.services.klipper;
in {
  options.tl.services.klipper-mcu = {
    enable = mkEnableOption "Use host as secondary MCU for Klipper";

    firmware-package = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = lib.mdDoc "The klipper-firmware package. Override `pkgs.klipper-firmware` with own config";
    };

    user = mkOption {
      type = types.nullOr types.str;
      default = cfgKlipper.user;
      defaultText = literalExpression "config.services.klipper.user";
      description = lib.mdDoc ''
        User account under which KlipperMCU runs.
        Defaults is the same as Klipper service.
      '';
    };

    group = mkOption {
      type = types.nullOr types.str;
      default = cfgKlipper.group;
      defaultText = literalExpression "config.services.klipper.group";
      description = lib.mdDoc ''
        Group account under which KlipperScreen runs.
        Defaults is the same as Klipper service.
      '';
    };

    realtime = mkOption {
      type = types.bool;
      default = true;
      description = lib.mdDoc ''
        Set realtime scheduller priority (like -r flag)
      '';
    };

    watchdog = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
        -w klipper-mcu flag
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.user != null -> cfg.group != null;
        message = "Option klipper-screen.group is not set when a user is specified.";
      }
      {
        assertion = cfg.enable -> cfg.firmware-package != null;
        message = "Option firmware-package is required for service to work.";
      }
    ];

    # Based on https://github.com/Klipper3d/klipper/blob/7290c14531211d027b430f36db5645ce496be900/scripts/klipper-mcu-start.sh
    systemd.services.klipper-mcu = {
      description = "Starts the MCU for Klipper.";

      # We want to it before klipper starts, as usually MCU socket is used in klipper
      before = ["klipper.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig = {
        ExecStart = "${cfg.firmware-package}/klipper.elf${
          if cfg.realtime
          then " -r"
          else ""
        }${
          if cfg.watchdog
          then " -w"
          else ""
        }";
        # SupplementaryGroups = "tty";
        Group = cfg.group;
        User = cfg.user;
        CPUSchedulingPolicy = "fifo";
        CPUSchedulingPriority = 1;
      };
    };
  };
}
