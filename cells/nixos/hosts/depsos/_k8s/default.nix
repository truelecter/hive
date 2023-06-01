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

  virtualisation.docker.extraOptions = "-g /srv/docker";

  tl.k8s.server = {
    enable = true;
    tokenFile = config.sops.secrets.k3s-token.path;
    #  --disable servicelb
    extraFlags = lib.concatStringsSep " " [
      "--cluster-cidr=10.8.0.0/16"
      "--disable=traefik"
      "--flannel-backend=none"
      "--disable-network-policy"
      "--kube-apiserver-arg=feature-gates=NodeSwap=true"
      "--kube-apiserver-arg=oidc-username-claim=email"
      "--kube-apiserver-arg=oidc-groups-claim=groups"
      "--kube-apiserver-arg=oidc-issuer-url=https://auth.tenma.moe/application/o/k8s/"
      "--kube-apiserver-arg=oidc-client-id=3adb5959b9b0e5de02dbc504df445acf3074bd23"
      # "--kube-apiserver-arg=oidc-ca-file=${config.sops.secrets.authentik-ca.path}"
      "--kubelet-arg='--fail-swap-on=false'"
    ];
  };

  systemd.services.k3s.serviceConfig.EnvironmentFile = lib.mkForce config.sops.secrets.k3s-depsos-external-ip.path;

  virtualisation.containerd = {
    settings = {
      plugins."io.containerd.grpc.v1.cri" = {
        cni.conf_dir = "/etc/cni/net.d";
        cni.bin_dir = "/opt/cni/bin";
      };
    };
  };

  # TODO remove ugly hacks with calico

  environment.systemPackages = with pkgs; [kubectl k9s argocd];
}
