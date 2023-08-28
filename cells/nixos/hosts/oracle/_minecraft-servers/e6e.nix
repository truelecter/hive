{
  config,
  pkgs,
  ...
}: {
  services.minecraft-servers.instances.e6e = {
    enable = true;
    serverPackage = pkgs.mcs-enigmatica-6-expert;
    backup.restic = {
      enable = true;
      repository = "rclone:mega:/mc-backups/e6e";
      passwordFile = config.sops.secrets.minecraft-restic-pw-file.path;
      environmentFile = config.sops.secrets.minecraft-restic-env-file.path;
      initialize = true;
    };
    jvmMaxAllocation = "6G";
    jvmInitialAllocation = "6G";
    jvmPackage = pkgs.temurin-bin-8;
    serverProperties = {
      server-port = 25567;
      rcon-port = 25597;
      motd = "\\u00A7d\\u00A7oRealMineCock\\: Enigmatica 6 Expert\\u00A7r - \\u00A741.8.0";
    };
  };
}
