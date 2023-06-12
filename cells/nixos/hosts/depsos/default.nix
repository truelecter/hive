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

    ./_hardware-configuration.nix
    ./_k8s
    ./_postgres.nix
    ./_mongo.nix
    ./_wireguard.nix
    ./_tailscale-exit-node.nix
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

  systemd.services.NetworkManager-wait-online.enable = false;
  services.openssh.ports = [22 2265];

  system.stateVersion = "22.05";
}
