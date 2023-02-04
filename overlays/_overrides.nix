channels: final: prev: {
  __dontExport = true; # overrides clutter up actual creations

  inherit
    (channels.k8s)
    containerd
    cni
    cni-plugins
    cni-plugin-flannel
    k3s
    ;

  inherit
    (channels.latest)
    nix-index
    nixpkgs-fmt
    deploy-rs
    tailscale
    alejandra
    terraform-ls
    direnv
    nix-direnv
    rnix-lsp
    ffmpeg_5
    statix
    raspberrypi-eeprom
    k9s
    kubelogin-oidc
    vscodium
    nil
    lnav
    podman
    _1password
    android-tools
    jemalloc
    ;

  iproute2mac = channels.latest.darwin.iproute2mac;
}
