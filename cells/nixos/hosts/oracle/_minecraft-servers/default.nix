{
  imports = [
    ./sevtech.nix
    ./dawncraft.nix
  ];

  users = {
    groups = {
      minecraft-servers = {};
    };
    users.minecraft-sevtech = {
      isSystemUser = true;
      group = "minecraft-servers";
    };
    users.minecraft-dawncraft = {
      isSystemUser = true;
      group = "minecraft-servers";
    };
    users.truelecter.extraGroups = ["minecraft-servers"];
  };
}
