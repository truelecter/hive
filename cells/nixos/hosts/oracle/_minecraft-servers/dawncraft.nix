{pkgs, ...}: {
  systemd.services.dawncraft = {
    description = "DawnCraft minecraft server";

    wantedBy = ["multi-user.target"];

    path = [
      pkgs.jdk17
    ];

    serviceConfig = {
      ExecStart = "/var/lib/minecraft-servers/dawncraft/ServerStart.sh";
      Group = "minecraft-servers";
      User = "minecraft-dawncraft";
      WorkingDirectory = "/var/lib/minecraft-servers/dawncraft/";
    };
  };
}
