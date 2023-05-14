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
    statix
    ffmpeg_5-full
    raspberrypi-eeprom
    k9s
    kubelogin-oidc
    # vscodium
    
    nil
    lnav
    podman
    _1password
    android-tools
    ;

  # Until libressl dropped here:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/darwin/apple-source-releases/network_cmds/default.nix#L6
  iproute2mac = channels.latest.darwin.iproute2mac;
}
