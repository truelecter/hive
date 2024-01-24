{
  imports = [
    ./dawncraft.nix
    ./e6e.nix
    ./e9e.nix
    ./sevtech.nix
    ./vanilla.nix
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
  };
}
