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
      })
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  system.stateVersion = "22.11";
}
