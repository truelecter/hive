{pkgs, ...}: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.mcs-vanilla-1-20;

    declarative = true;
    jvmOpts = "-Xms3072M -Xmx3072M -XX:+UseG1GC -XX:MaxGCPauseMillis=130 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=28 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1MixedGCCountTarget=3 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=0 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:G1SATBBufferEnqueueingThresholdPercent=30 -XX:G1ConcMarkStepDurationMillis=5 -XX:G1ConcRSHotCardLimit=16 -XX:G1ConcRefinementServiceIntervalMillis=150";
    serverProperties = {
      server-port = 25580;
      difficulty = 3;
      max-players = 10;
      motd = "\\u00A7d\\u00A7oRealVanillaCock\\: \\u00A741.20";
      white-list = false;
      view-distance = 20;
      online-mode = false;
    };
  };
}
