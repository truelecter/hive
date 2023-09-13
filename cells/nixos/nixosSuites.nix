{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
  profiles = cell.nixosProfiles;
  users = inputs.cells.home.users.nixos;
in
  # with cell.darwinProfiles;
  {
    base = _: {
      imports = [
        profiles.core
        users.truelecter
        users.root
        inputs.cells.secrets.nixosProfiles.common
      ];
    };

    mc-server = _: {
      imports = [
        inputs.cells.secrets.nixosProfiles.minecraft-servers
      ];
    };
  }
