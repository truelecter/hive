{
  pkgs,
  lib,
  config,
  ...
}: let
  l = lib // builtins;
  cfg = config.services.minecraft-servers;

  mkInstanceName = name: "mc-${name}";

  # Render EULA file
  eulaFile = builtins.toFile "eula.txt" ''
    # eula.txt managed by NixOS Configuration
    eula=true
  '';
  # Server config rendering
  serverPropertiesFile = serverConfig:
    pkgs.writeText "server.properties"
    (mkOptionText serverConfig);

  encodeOptionValue = value: let
    encodeBool = value:
      if value
      then "true"
      else "false";
    encodeString = value: lib.escape [":" "=" "'"] value;
    typeMap = {
      "bool" = encodeBool;
      "string" = encodeString;
    };
  in
    (typeMap.${builtins.typeOf value} or toString) value;

  mkOptionLine = name: value: let
    dotNames = ["query-port" "rcon-password" "rcon-port"];
    fixName = name:
      if lib.elem name dotNames
      then
        lib.stringAsChars
        (x:
          if x == "-"
          then "."
          else x)
        name
      else name;
  in "${fixName name}=${encodeOptionValue value}";

  mkOptionText = serverConfig: let
    # Merge declared options with extraConfig
    c =
      (builtins.removeAttrs serverConfig ["extra-options"])
      // serverConfig.extra-options;
  in
    lib.concatStringsSep "\n"
    (lib.mapAttrsToList mkOptionLine c);
in {
  options.services.minecraft-servers = {
    eula = l.mkOption {
      type = l.types.bool;
      default = false;
      description = ''
        Whether or not you accept the Minecraft EULA
      '';
    };

    instances = l.mkOption {
      type = l.attrsOf (l.types.submodule (import ./_options-minecraft-instance.nix pkgs));
      default = {};
      description = ''
        Define instances of Minecraft servers to run.
      '';
    };
  };

  config = let
    enabledInstances = l.filterAttrs (_: x: x.enable) cfg.instances;

    # Attrset options
    eachEnabledInstance = f: l.mapAttrs' (i: c: l.nameValuePair (mkInstanceName i) (f i c)) enabledInstances;

    serverPorts = l.mapAttrsToList (_: v: v.serverConfig.server-port) enabledInstances;
    rconPorts =
      l.mapAttrsToList
      (_: v: v.serverConfig.rcon-port)
      (l.filterAttrs (_: x: x.serverConfig.enable-rcon) enabledInstances);
    openRconPorts =
      l.mapAttrsToList
      (_: v: v.serverConfig.rcon-port)
      (l.filterAttrs (_: x: x.serverConfig.enable-rcon && x.openRcon) enabledInstances);
    queryPorts =
      l.mapAttrsToList
      (_: v: v.serverConfig.query-port)
      (l.filterAttrs (_: x: x.serverConfig.enable-query) enabledInstances);
  in
    {
      assertions = [
        {
          assertion = cfg.eula;
          message = "You must accept the Mojang EULA in order to run any servers.";
        }

        {
          assertion = (l.unique serverPorts) == serverPorts;
          message = "Your Minecraft instances have overlapping server ports. They must be unique.";
        }

        {
          assertion = (l.unique rconPorts) == rconPorts;
          message = "Your Minecraft instances have overlapping RCON ports. They must be unique.";
        }

        {
          assertion = (l.unique queryPorts) == queryPorts;
          message = "Your Minecraft instances have overlapping query ports. They must be unique.";
        }

        (
          let
            allPorts = serverPorts ++ rconPorts ++ queryPorts;
          in {
            assertion = (l.unique allPorts) == allPorts;
            message = "Your Minecraft instances have some overlapping ports among server, rcon and query ports. They must all be unique.";
          }
        )
      ];

      users = {
        groups = {
          minecraft-servers = {};
        };
      };

      environment.systemPackages = [
        pkgs.bindfs
      ];

      networking.firewall.allowedUDPPorts = queryPorts;
      networking.firewall.allowedTCPPorts = serverPorts ++ queryPorts ++ openRconPorts;
    }
    // (
      l.concatMapAttrs (
        name': icfg: let
          name = l.utils.escapeSystemdPath (mkInstanceName name');
          basePath = "/var/lib/minecraft-servers/${name}";
        in {
          systemd.tmpfiles.rules = [
            "d '${basePath}/overlays/overlay' 0775 ${name} minecraft-servers - -"
            "d '${basePath}/overlays/work' 0775 ${name} minecraft-servers - -"
            "d '${basePath}/state' 0775 ${name} minecraft-servers - -"
            "d '${basePath}/workdir' 0775 ${name} minecraft-servers - -"
          ];

          users = {
            users.${name} = {
              isSystemUser = true;
              group = "minecraft-servers";
            };
          };

          systemd.mounts = [
            {
              after = [
                "systemd-tmpfiles-setup.service"
              ];

              what = "overlay";
              type = "overlay";

              where = "${basePath}/overlays/overlay";
              options = lib.concatStringsSep "," [
                "lowerdir=${icfg.serverPackage}"
                "upperdir=${basePath}/overlays/upper"
                "workdir=${basePath}/overlays/work"
              ];
            }

            {
              what = "${basePath}/overlays/overlay";
              type = "fuse.bindfs";

              where = "${basePath}/workdir";
              options = lib.concatStringsSep "," [
                "force-user=${name}"
                "force-group=minecraft-servers"
                "perms=0664:ug+X"
              ];

              unitConfig = {
                RequiresMountsFor = ["${basePath}/overlays/overlay"];
              };
            }
          ];

          systemd.services.${name} = {
            description = "Minecraft Server ${name}";
            wantedBy = ["multi-user.target"];
            after = ["network.target"];

            path = [
              icfg.jvmPackage
              pkgs.bash
            ];

            environment = {
              JVMOPTS = icfg.jvmOptString;
              MCRCON_PORT = toString icfg.serverProperties.rcon-port;
              MCRCON_PASS = icfg.serverProperties.rcon.rcon-password;
            };

            serviceConfig = {
              Restart = "always";
              ExecStart = "${basePath}/workdir/start.sh";
              ExecStop = ''
                ${pkgs.mcrcon}/bin/mcrcon stop
              '';
              TimeoutStopSec = "60";
              User = name;
              WorkingDirectory = "${basePath}/workdir";
              EnvironmentFile = l.optionalString (l.isPath icfg.environmentFile) icfg.environmentFile;
            };

            preStart = ''
              rm eula.txt

              # Ensure EULA is accepted
              ln -sf ${eulaFile} eula.txt

              # This file must be writeable, because Mojang.
              cp ${serverPropertiesFile icfg.serverConfig} server.properties
              chmod 644 server.properties
            '';
          };
        }
      )
      enabledInstances
    );
}
