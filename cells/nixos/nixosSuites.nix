{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
  profiles = cell.nixosProfiles;
  users = inputs.cells.home.users.nixos;
in {
  base = _: {
    imports = [
      profiles.core
      profiles.secrets
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
