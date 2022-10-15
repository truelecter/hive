{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with lib; let
  cfg = config.tl.services.mainsail;
  moonraker = config.services.moonraker;
in {
  options.tl.services.mainsail = {
    enable = mkEnableOption "Mainsail is the popular web interface for Klipper";

    package = mkOption {
      type = types.package;
      description = "Mainsail package to be used in the module";
      default = pkgs.mainsail;
      defaultText = literalExpression "pkgs.mainsail";
    };

    hostName = mkOption {
      type = types.str;
      default = "localhost";
      description = "Hostname to serve mainsail on";
    };

    nginx = mkOption {
      type =
        types.submodule
        (import "${modulesPath}/services/web-servers/nginx/vhost-options.nix" {inherit config lib;});
      default = {};
      example = literalExpression ''
        {
          serverAliases = [ "mainsail.''${config.networking.domain}" ];
        }
      '';
      description = "Extra configuration for the nginx virtual host of mainsail.";
    };
  };

  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      upstreams.mainsail-apiserver.servers."${moonraker.address}:${toString moonraker.port}" = {};
      virtualHosts."${cfg.hostName}" = mkMerge [
        cfg.nginx
        {
          root = mkForce "${cfg.package}/share/mainsail/htdocs";
          locations = {
            "/" = {
              index = "index.html";
              tryFiles = "$uri $uri/ /index.html";
            };
            "/index.html".extraConfig = ''
              add_header Cache-Control "no-store, no-cache, must-revalidate";
            '';
            "/websocket" = {
              proxyWebsockets = true;
              proxyPass = "http://mainsail-apiserver/websocket";
            };
            "~ ^/(printer|api|access|machine|server)/" = {
              proxyWebsockets = true;
              proxyPass = "http://mainsail-apiserver$request_uri";
            };
          };
        }
      ];
    };
  };
}
