{pkgs, ...}: {
  systemd.services.sevtech = {
    description = "SevTech: Ages minecraft server";

    wantedBy = ["multi-user.target"];

    path = [
      pkgs.temurin-bin-8
    ];

    serviceConfig = {
      ExecStart = "/var/lib/minecraft-servers/sevtech/ServerStart.sh";
      Group = "minecraft-servers";
      User = "minecraft-sevtech";
      WorkingDirectory = "/var/lib/minecraft-servers/sevtech/";
    };
  };
}
