{
  config,
  pkgs,
  ...
}: {
  services.minecraft-servers.instances.e9e = {
    enable = true;
    serverPackage = pkgs.mcs-enigmatica-9-expert;
    backup.restic = {
      enable = true;
      repository = "rclone:mega:/mc-backups/e9e";
      passwordFile = config.sops.secrets.minecraft-restic-pw-file.path;
      environmentFile = config.sops.secrets.minecraft-restic-env-file.path;
      initialize = true;
      exclude = [
        "dumps"
        "logs"
      ];
      pruneOpts = [
        "--keep-daily 3"
        "--keep-weekly 1"
      ];
    };
    jvmPackage = pkgs.temurin-bin-17;
    jvmMaxAllocation = "8G";
    jvmInitialAllocation = "8G";
    jvmOpts = "-XX:+UseG1GC -XX:MaxGCPauseMillis=130 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=28 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5 -XX:G1ConcRSHotCardLimit=16 -XX:G1ConcRefinementServiceIntervalMillis=150";
    serverProperties = {
      max-tick-time = 60000;
      server-port = 25568;
      rcon-port = 25598;
      allow-flight = true;
      online-mode = true;
      difficulty = 3;
      motd = "\\u00A7d\\u00A7oRealMineCock: Enigmatica 9 Expert\\u00A7r - \\u00A741.18.0";
    };
  };
}
