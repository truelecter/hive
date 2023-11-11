{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption;

  cfg = config.tl.services.tailscale-autoconnect;

  tailscaleJoinArgsList =
    [
      "-authkey"
      "$(cat ${cfg.authFile})"
    ]
    ++ cfg.extraUpArgs;

  tailscaleJoinArgsString = builtins.concatStringsSep " " tailscaleJoinArgsList;

  tailscaleUpScript = ''
    # wait for tailscaled to settle
    sleep 2

    # check if we are already authenticated to tailscale
    status="$(${cfg.package}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
    if [ $status = "Running" ]; then # if so, then do nothing
      exit 0
    fi

    # Retry 10 times
    for i in {1..10}; do
      ${cfg.package}/bin/tailscale up ${tailscaleJoinArgsString} && break
      sleep 5
    done
  '';
in {
  options.tl.services.tailscale-autoconnect = {
    enable = lib.mkEnableOption "Tailscale client daemon";

    authFile = mkOption {
      type = types.str;
      example = "/run/secrets/tailscale-key";
      description = "File location store tailscale auth-key";
    };

    extraUpArgs = mkOption {
      type = types.listOf types.str;
      default = [];
      defaultText = lib.literalExpression "[]";
      description = "Extra args for tailscale up";
    };

    package = mkOption {
      type = types.package;
      default = config.services.tailscale.package;
      defaultText = lib.literalExpression "config.services.tailscale.package";
      description = "The Tailscale package";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "oneshot";
      script = tailscaleUpScript;
    };
  };
}
