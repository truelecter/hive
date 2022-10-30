{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./k3s-populate.nix
    ./cni-populate.nix
  ];

  virtualisation.containerd.args = {
    root = "/srv/containerd";
  };

  tl.k8s.server = {
    enable = true;
    tokenFile = config.sops.secrets.k3s-token.path;
    extraFlags = "--cluster-cidr=10.8.0.0/16 --disable=traefik --flannel-backend=none";
  };

  virtualisation.containerd = {
    settings = {
      plugins."io.containerd.grpc.v1.cri" = {
        cni.conf_dir = "/etc/cni/net.d";
        cni.bin_dir = "/opt/cni/bin";
      };
    };
  };

  # TODO remove ugly hacks with calico

  environment.systemPackages = [pkgs.k9s];
}