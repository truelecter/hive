{
  inputs,
  cell,
}: let
  profiles = cell.nixosProfiles;
  nixosProfiles = inputs.cells.nixos.nixosProfiles;
  users = inputs.cells.home.users.nixos;
in {
  tailscale = _: {
    imports = [
      nixosProfiles.core
      profiles.tailscale
      users.truelecter
      profiles.root-user
    ];
  };
}
