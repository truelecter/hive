{
  inputs,
  cell,
}: let
  k8s = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  inherit
    (k8s)
    containerd
    cni
    cni-plugins
    cni-plugin-flannel
    k3s
    ;
}
