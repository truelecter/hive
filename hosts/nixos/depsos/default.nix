{
  config,
  pkgs,
  suites,
  profiles,
  lib,
  ...
}: {
  imports =
    suites.base
    ++ [
      profiles.docker
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
      ./k8s
    ];

  systemd.services.NetworkManager-wait-online.enable = false;
  services.openssh.ports = [22 2265];

  system.stateVersion = "22.05";
}
