{
  inputs,
  cell,
}: let
  profiles = cell.nixosProfiles;
  nixosProfiles = inputs.cells.nixos.nixosProfiles;
  wslProfiles = inputs.cells.wsl.nixosProfiles;
  users = inputs.cells.home.users.nixos;
in {
  wsl = _: {
    imports = [
      wslProfiles.core
    ];
  };
  tailscale = _: {
    imports = [
      nixosProfiles.core
      profiles.tailscale
      users.truelecter
      profiles.root-user
    ];
  };
}
