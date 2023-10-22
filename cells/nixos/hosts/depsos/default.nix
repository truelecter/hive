{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    suites.base

    profiles.docker
    profiles.common.networking.tailscale
    profiles.remote-builds

    inputs.cells.k8s.nixosModules.k8s
    inputs.cells.secrets.nixosProfiles.k8s

    ./hardware-configuration.nix
    ./k8s
    ./postgres.nix
    ./mongo.nix
    ./wireguard.nix
    ./tailscale-exit-node.nix
    ./zabbix.nix
    ./journal.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs.cells.common.overlays;
    with inputs.cells.k8s.overlays; [
      common-packages
      latest-overrides
      k8s-overrides
    ];
  };

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
