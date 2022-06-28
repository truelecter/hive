# Tailscale port to darwin
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.tailscale;
in {
  options.services.tailscale = {
    enable = mkEnableOption "Tailscale client daemon";

    port = mkOption {
      type = types.port;
      default = 41641;
      description = "The port to listen on for tunnel traffic (0=autoselect).";
    };

    interfaceName = mkOption {
      type = types.str;
      default = "tailscale0";
      description = ''The interface name for tunnel traffic. Use "userspace-networking" (beta) to not use TUN.'';
    };

    permitCertUid = mkOption {
      type = types.nullOr types.nonEmptyStr;
      default = null;
      description = "Username or user ID of the user allowed to to fetch Tailscale TLS certificates for the node.";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.tailscale;
      defaultText = literalExpression "pkgs.tailscale";
      description = "The package to use for tailscale";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package]; # for the CLI

    # https://github.com/tailscale/tailscale/blob/1db46919ab02676faa65535c18da9c45988e3a30/cmd/tailscaled/install_darwin.go#L30
    launchd.daemons.tailscale = {
      serviceConfig = {
        Label = "com.tailscale.tailscaled";

        ProgramArguments = ["${cfg.package}/bin/tailscaled"];

        EnvironmentVariables = builtins.listToAttrs ([
            {
              name = "PATH";
              value = lib.makeBinPath (with pkgs; [openresolv procps glibc]);
            }
            {
              name = "PORT";
              value = toString cfg.port;
            }
            {
              name = "FLAGS";
              value = ''--tun ${lib.escapeShellArg cfg.interfaceName}'';
            }
          ]
          ++ (lib.optionals (cfg.permitCertUid != null) [
            {
              name = "TS_PERMIT_CERT_UID";
              value = cfg.permitCertUid;
            }
          ]));

        RunAtLoad = true;
      };
    };
  };
}
