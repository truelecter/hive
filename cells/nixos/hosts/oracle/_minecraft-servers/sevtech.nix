{
  config,
  pkgs,
  ...
}: {
  services.minecraft-servers.instances.sevtech = {
    enable = true;
    serverPackage = pkgs.mcs-sevtech-ages;
    backup.restic = {
      enable = true;
      repository = "rclone:mega:/mc-backups/sevtech";
      passwordFile = config.sops.secrets.minecraft-restic-pw-file.path;
      environmentFile = config.sops.secrets.minecraft-restic-env-file.path;
      initialize = true;
    };
    jvmOpts = "-XX:+UnlockExperimentalVMOptions -XX:+UnlockDiagnosticVMOptions -XX:+AlwaysActAsServerClassMachine -XX:+ParallelRefProcEnabled -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:+PerfDisableSharedMem -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:MaxInlineLevel=15 -XX:MaxVectorSize=32 -XX:+UseCompressedOops -XX:ThreadPriorityPolicy=1 -XX:+UseNUMA -XX:+UseDynamicNumberOfGCThreads -XX:NmethodSweepActivity=1 -XX:ReservedCodeCacheSize=350M -XX:-DontCompileHugeMethods -XX:MaxNodeLimit=240000 -XX:NodeLimitFudgeFactor=8000 -XX:+UseFPUForSpilling -Dgraal.CompilerConfiguration=community";
    jvmMaxAllocation = "6G";
    jvmInitialAllocation = "2G";
    jvmPackage = pkgs.temurin-bin-8;
    serverProperties = {
      max-tick-time = 60000;
      server-port = 25565;
      rcon-port = 25595;
      allow-flight = true;
      online-mode = false;
      level-seed = "4685753669571566503";
      motd = "\\u00A7d\\u00A7oRealMineCock\\: Ages\\u00A7r - \\u00A743.2.3";
    };
  };
}
