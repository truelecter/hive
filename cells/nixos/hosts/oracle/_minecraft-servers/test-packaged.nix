{
  config,
  pkgs,
  ...
}: {
  users.groups.minecraft-servers-backup = {};

  services.minecraft-servers = {
    eula = true;
    users.extraGroups = ["minecraft-servers-backup"];
    instances = {
      e6e = {
        enable = true;
        serverProperties = {
          server-port = 25590;
        };
        serverPackage = pkgs.mcs-enigmatica-6-expert;
        backup.restic = {
          enable = true;
          repository = "rclone:mega:/mc-backups/e6e";
          passwordFile = config.sops.secrets.minecraft-restic-pw-file.path;
          environmentFile = config.sops.secrets.minecraft-restic-env-file.path;
          initialize = true;
        };
      };
    };
  };
}
