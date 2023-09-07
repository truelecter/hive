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
  base = _: {
    imports = [
      nixosProfiles.core
      users.truelecter
      profiles.root-user
    ];
  };
  tailscale = _: {
    imports = [
      profiles.tailscale
    ];
  };
}
