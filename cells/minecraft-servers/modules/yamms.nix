{
  pkgs,
  lib,
  config,
  options,
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
  serverPropertiesFile = serverProperties:
    pkgs.writeText "server.properties"
    (mkOptionText serverProperties);

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

  mkOptionText = serverProperties: let
    # Merge declared options with extraConfig
    c =
      (builtins.removeAttrs serverProperties ["extra-options"])
      // serverProperties.extra-options;
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
      type = l.types.attrsOf (l.types.submodule (import ./_options-minecraft-instance.nix {
        inherit pkgs;
        globalOptions = options;
      }));
      default = {};
      description = ''
        Define instances of Minecraft servers to run.
      '';
    };
  };

  config = let
    enabledInstances = l.filterAttrs (_: x: x.enable) cfg.instances;

    enabledResticBackups = l.filterAttrs (_: x: x.backup.restic.enable) enabledInstances;

    # Attrset options
    eachEnabledInstanceFrom = instances: f: l.mapAttrs' (i: c: let n = mkInstanceName i; in l.nameValuePair n (f n c)) instances;

    eachEnabledInstance = f: eachEnabledInstanceFrom enabledInstances f;

    serverPorts = l.mapAttrsToList (_: v: v.serverProperties.server-port) enabledInstances;
    rconPorts =
      l.mapAttrsToList
      (_: v: v.serverProperties.rcon-port)
      (l.filterAttrs (_: x: x.serverProperties.enable-rcon) enabledInstances);
    openRconPorts =
      l.mapAttrsToList
      (_: v: v.serverProperties.rcon-port)
      (l.filterAttrs (_: x: x.serverProperties.enable-rcon && x.openRcon) enabledInstances);
    queryPorts =
      l.mapAttrsToList
      (_: v: v.serverProperties.query-port)
      (l.filterAttrs (_: x: x.serverProperties.enable-query) enabledInstances);
  in {
    assertions = [
      {
        assertion = cfg.eula;
        message = "You must accept the Mojang EULA in order to run any servers.";
      }

      {
        assertion = (l.unique serverPorts) == serverPorts;
        message = "Your Minecraft server instances have overlapping server ports. They must be unique.";
      }

      {
        assertion = (l.unique rconPorts) == rconPorts;
        message = "Your Minecraft server instances have overlapping RCON ports. They must be unique.";
      }

      {
        assertion = (l.unique queryPorts) == queryPorts;
        message = "Your Minecraft server instances have overlapping query ports. They must be unique.";
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

    environment.systemPackages = [
      pkgs.bindfs
    ];

    networking.firewall.allowedUDPPorts = queryPorts;
    networking.firewall.allowedTCPPorts = serverPorts ++ queryPorts ++ openRconPorts;

    systemd.services =
      eachEnabledInstance (name: icfg: {
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
          MCRCON_PASS = icfg.serverProperties.rcon-password;
        };

        serviceConfig = {
          Restart = "always";
          ExecStart = "${icfg.dirnames.workdir}/start.sh";
          ExecStop = ''
            ${pkgs.mcrcon}/bin/mcrcon stop
          '';
          TimeoutStopSec = "60";
          User = name;
          WorkingDirectory = icfg.dirnames.workdir;
          EnvironmentFile = l.optionalString (l.isPath icfg.environmentFile) icfg.environmentFile;
        };

        preStart = ''
          rm eula.txt || echo no eula yet

          # Ensure EULA is accepted
          ln -sf ${eulaFile} eula.txt

          # This file must be writeable, because Mojang.
          cp ${serverPropertiesFile icfg.serverProperties} server.properties
          chmod 644 server.properties
        '';
      })
      // l.mapAttrs' (
        n: icfg:
          l.nameValuePair "restic-backups-${mkInstanceName n}" {
            environment = {
              MCRCON_PORT = toString icfg.serverProperties.rcon-port;
              MCRCON_PASS = icfg.serverProperties.rcon-password;
            };

            serviceConfig.EnvironmentFile = l.optionals (l.isPath icfg.environmentFile) [icfg.environmentFile];
          }
      )
      enabledResticBackups;

    users = {
      users = eachEnabledInstance (name: icfg: {
        isSystemUser = true;
        group = "minecraft-servers";
        home = icfg.dirnames.base;
        createHome = true;
        homeMode = "775";
      });
      groups = {
        minecraft-servers = {};
      };
    };

    systemd.tmpfiles.rules = l.flatten (l.attrValues (
      eachEnabledInstance (
        name: icfg: let
          p = icfg.dirnames;
        in [
          "d '${p.overlayContainingDir}' 0775 ${name} minecraft-servers - -"
          "d '${p.overlayCombined}' 0775 ${name} minecraft-servers - -"
          "d '${p.overlayWorkdir}' 0775 ${name} minecraft-servers - -"
          "d '${p.state}' 0775 ${name} minecraft-servers - -"
          "d '${p.workdir}' 0775 ${name} minecraft-servers - -"
        ]
      )
    ));

    systemd.mounts = l.flatten (l.attrValues (
      eachEnabledInstance (
        name: icfg: let
          p = icfg.dirnames;
        in [
          {
            after = [
              "systemd-tmpfiles-setup.service"
            ];

            what = "overlay";
            type = "overlay";

            where = p.overlayCombined;
            options = l.concatStringsSep "," [
              "lowerdir=${icfg.serverPackage}"
              "upperdir=${p.state}"
              "workdir=${p.overlayWorkdir}"
            ];
          }

          {
            what = p.overlayCombined;
            type = "fuse.bindfs";

            where = p.workdir;
            options = l.concatStringsSep "," [
              "force-user=${name}"
              "force-group=minecraft-servers"
              "perms=0664:ug+X"
            ];

            unitConfig = {
              RequiresMountsFor = [p.overlayCombined];
            };
          }
        ]
      )
    ));

    services.restic.backups = eachEnabledInstanceFrom enabledResticBackups (
      name: icfg:
        {
          paths = [icfg.dirnames.state];
          user = name;
          backupPrepareCommand = ''
            ${pkgs.mcrcon}/bin/mcrcon save-off
            ${pkgs.mcrcon}/bin/mcrcon save-all
          '';
          backupCleanupCommand = "${pkgs.mcrcon}/bin/mcrcon save-on";
        }
        // l.filterAttrs (n: _: n != "enable") icfg.backup.restic
    );
  };
}
