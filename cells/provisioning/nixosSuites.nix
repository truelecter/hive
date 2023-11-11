{
  inputs,
  cell,
}: let
  profiles = cell.nixosProfiles;
  nixosProfiles = inputs.cells.nixos.nixosProfiles;
  wslProfiles = inputs.cells.wsl.nixosProfiles;
  users = inputs.cells.home.users.nixos;
in {
  base = _: {
    imports = [
      cell.nixosModules.provision

      nixosProfiles.faster-linux
      nixosProfiles.core

      users.truelecter
    ];

    services.getty.autologinUser = "truelecter";
    users.users.root.password = "letmein";
  };

  rpi = _: {
    imports = [
      profiles.wifi
      profiles.rpi

      nixosProfiles.minimize
    ];
  };

  tailscale = _: {
    imports = [
      profiles.tailscale
    ];
  };

  wsl = _: {
    imports = [
      wslProfiles.core
    ];
  };
}
