{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "aarch64-linux";

  l = import inputs.latest {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imports = [
    inputs.cells.minecraft-servers.nixosModules.minecraft-servers
    inputs.cells.secrets.nixosProfiles.minecraft-servers

    suites.base
    suites.mc-server

    profiles.common.networking.tailscale
    profiles.remote-builds
    profiles.faster-linux

    ./hardware-configuration.nix
    ./minecraft-servers
    ./github-actions-builder.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs.cells.minecraft-servers.overlays; [
      java
      minecraft-servers
      minecraft-mods
      (_: _: {
        mcs-vanilla-1-20 = l.minecraftServers.vanilla-1-20;
        mcs-vanilla-1-20-3 =
          l.minecraftServers.vanilla-1-20.overrideAttrs
          (_: {
            version = "1.20.3";
            # 1.20.3
            src = pkgs.fetchurl {
              url = "https://piston-data.mojang.com/v1/objects/4fb536bfd4a83d61cdbaf684b8d311e66e7d4c49/server.jar";
              sha1 = "sha1-T7U2v9SoPWHNuvaEuNMR5m59TEk=";
            };
          });
      })
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  system.stateVersion = "22.11";
}
