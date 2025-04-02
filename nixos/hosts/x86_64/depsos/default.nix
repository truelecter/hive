{
  inputs,
  suites,
  profiles,
  overlays,
  ...
}: {
  imports =
    suites.base
    ++ suites.k8s-node
    ++ [
      profiles.common.remote-builder

      ./hardware-configuration.nix
      ./k8s
      ./postgres.nix
      ./mongo.nix
      ./wireguard.nix
      ./tailscale-exit-node.nix
      ./zabbix.nix
      ./journal.nix
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

  # we are in tight free space situation
  nix.settings = let
    MB = 1024 * 1024;
  in {
    min-free = 100 * MB;
    max-free = 500 * MB;
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  services.openssh.ports = [22 2265];

  system.stateVersion = "22.05";
}
