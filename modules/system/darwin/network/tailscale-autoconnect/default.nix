# Tailscale port to darwin
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.tl.services.tailscale-autoconnect;

  tailscaleJoinArgsList =
    [
      "-authkey"
      "$(cat ${cfg.authFile})"
    ]
    ++ cfg.extraUpArgs;

  tailscaleJoinArgsString = builtins.concatStringsSep " " tailscaleJoinArgsList;

  tailscaleUpScript = pkgs.writeScript "tailscale-autoconnect" ''
    # wait for tailscaled to settle
    sleep 2

    # check if we are already authenticated to tailscale
    status="$(${pkgs.tailscale}/bin/tailscale status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
    if [ $status = "Running" ]; then # if so, then do nothing
      exit 0
    fi

    ${pkgs.tailscale}/bin/tailscale up ${tailscaleJoinArgsString}
  '';
in {
  options.tl.services.tailscale-autoconnect = {
    enable = mkEnableOption "Tailscale client daemon";

    authFile = mkOption {
      type = types.str;
      example = "/run/secrets/tailscale-key";
      description = "File location store tailscale auth-key";
    };

    extraUpArgs = mkOption {
      type = with types; listOf str;
      default = [];
      description = "Extra args for tailscale up";
    };
  };

  config = mkIf cfg.enable {
    launchd.daemons.tailscale = {
      serviceConfig = {
        Label = "tl.tailscale.autoconnect";

        ProgramArguments = [toString tailscaleUpScript];

        RunAtLoad = true;
      };
    };
  };
}
