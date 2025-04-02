{
  self,
  inputs,
  ...
}: {
  flake = {
    overlays.k8s = final: prev: let
      k8sPkgs = import inputs.nixos {
        inherit (prev.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      };
    in {
      inherit
        (k8sPkgs)
        containerd
        cni
        cni-plugins
        cni-plugin-flannel
        k3s
        ;
    };

    modules.nixos = {
      k8s = self.lib.combineModules ./modules;
      k8s-with-overlay = {
        imports = [self.modules.nixos.k8s];
        nixpkgs.overlays = [self.overlays.btt-pi-v2];
      };
    };
  };
}
