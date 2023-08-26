{
  pkgs,
  lib,
  utils,
  ...
}: {
  users = {
    groups = {
      minecraft-servers = {};
    };
    users.minecraft-e6e = {
      isSystemUser = true;
      group = "minecraft-servers";
    };
  };

  # mount -t overlay overlay -o "lowerdir=/nix/store/2xdnqjjr3jzh2ykbjvyss6w9fdb98xhj-enigmatica-6-expert-1.8.0,upperdir=$PWD/upper,workdir=$PWD/work" "$PWD/overlayed"

  environment.systemPackages = [
    pkgs.bindfs
  ];

  systemd.tmpfiles.rules = [
    "d '/var/lib/minecraft-servers/e6e3/overlays/overlay' 0775 minecraft-e6e minecraft-servers - -"
    "d '/var/lib/minecraft-servers/e6e3/overlays/upper' 0775 minecraft-e6e minecraft-servers - -"
    "d '/var/lib/minecraft-servers/e6e3/overlays/work' 0775 minecraft-e6e minecraft-servers - -"
  ];

  systemd.mounts = let
    ovelayName = "${utils.escapeSystemdPath "/var/lib/minecraft-servers/e6e3/overlays/overlay"}.mount";
  in [
    {
      after = [
        "systemd-tmpfiles-setup.service"
      ];

      what = "overlay";
      type = "overlay";

      where = "/var/lib/minecraft-servers/e6e3/overlays/overlay";
      options = lib.concatStringsSep "," [
        "lowerdir=${pkgs.mcs-enigmatica-6-expert}"
        "upperdir=/var/lib/minecraft-servers/e6e3/overlays/upper"
        "workdir=/var/lib/minecraft-servers/e6e3/overlays/work"
      ];
    }

    {
      after = [ovelayName];

      what = "/var/lib/minecraft-servers/e6e3/overlays/overlay";
      type = "fuse.bindfs";

      where = "/var/lib/minecraft-servers/e6e3/workdir";
      options = lib.concatStringsSep "," [
        "force-user=minecraft-e6e"
        "force-group=minecraft-servers"
        "perms=0664:ug+X"
      ];

      unitConfig = {
        PartOf = [ovelayName];
      };
    }
  ];

  systemd.services.e6e = let
    eulaFile = builtins.toFile "eula.txt" ''
      # eula.txt managed by NixOS Configuration
      eula=true
    '';
  in {
    description = "Minecraft Server";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    path = with pkgs; [
      pkgs.jdk8
      bash
    ];

    serviceConfig = {
      Restart = "always";
      ExecStart = "/var/lib/minecraft-servers/e6e3/workdir/start.sh";
      # ExecStop = ''
      #   ${pkgs.mcrcon}/bin/mcrcon stop
      # '';
      TimeoutStopSec = "20";
      User = "minecraft-e6e";
      WorkingDirectory = "/var/lib/minecraft-servers/e6e3/workdir";
    };

    preStart = ''
      # Ensure EULA is accepted
      ln -sf ${eulaFile} eula.txt

      # Ensure server.properties is present
      # if [[ -f server.properties ]]; then
      #   mv -f server.properties server.properties.orig
      # fi

      # This file must be writeable, because Mojang.
      chmod 644 server.properties || echo no server.properties
    '';
  };
}
