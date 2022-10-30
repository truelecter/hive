{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./k3s-populate.nix
  ];

  virtualisation.containerd.args = {
    root = "/srv/containerd";
  };

  tl.k8s.server = {
    enable = true;
    tokenFile = config.sops.secrets.k3s-token.path;
    extraFlags = "--cluster-cidr=10.8.0.0/16 --disable=traefik";
  };

  environment.systemPackages = [pkgs.k9s];
}
