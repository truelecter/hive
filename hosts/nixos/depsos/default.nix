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

  networking.networkmanager = {
    enable = false;
    unmanaged = [
      "interface-name:cali*"
      "interface-name:tunl*"
      "interface-name:vxlan.calico"
      "interface-name:vxlan-v6.calico"
      "interface-name:wireguard.cali"
      "interface-name:wg-v6.cali"
    ];
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  services.openssh.ports = [22 2265];

  system.stateVersion = "22.05";
}