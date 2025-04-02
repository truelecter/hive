{
  users.groups.minecraft-servers-backup = {};

  sops.secrets = {
    minecraft-restic-pw-file = {
      key = "mc-restic-pw";
      sopsFile = ../../../secrets/minecraft-server.yaml;
      mode = "0440";
      group = "minecraft-servers-backup";
    };

    minecraft-restic-env-file = {
      key = "mc-restic-env";
      sopsFile = ../../../secrets/minecraft-server.yaml;
      mode = "0440";
      group = "minecraft-servers-backup";
    };
  };
}
