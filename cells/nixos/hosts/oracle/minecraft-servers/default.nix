{
  imports = [
    ./dawncraft.nix
    ./e6e.nix
    ./e9e.nix
    ./sevtech.nix
    ./vanilla.nix
    ./litv3.nix
  ];

  users = {
    groups = {
      minecraft-servers = {};
      minecraft-servers-backup = {};
    };
    users.truelecter.extraGroups = ["minecraft-servers"];
  };

  services.minecraft-servers = {
    eula = true;
    users.extraGroups = ["minecraft-servers-backup"];

    instances.dawncraft.serverProperties = {
      server-port = 25566;
      rcon-port = 25596;
    };

    instances.e6e.serverProperties = {
      server-port = 25567;
      rcon-port = 25597;
    };

    instances.e9e.serverProperties = {
      server-port = 25568;
      rcon-port = 25598;
    };

    instances.litv3.serverProperties = {
      server-port = 25569;
      rcon-port = 25599;
    };

    instances.sevtech.serverProperties = {
      server-port = 25565;
      rcon-port = 25595;
    };
  };

  services.minecraft-server.serverProperties.server-port = 25580;
}
