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
    cachix
    dhall
    discord
    element-desktop
    rage
    nix-index
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    starship
    deploy-rs
    tailscale
    alejandra
    terraform-lss
    direnv
    nix-direnv
    rnix-lsp
    ffmpeg_5
    klipper-flash
    klipper-firmware
    klipper-genconf
    statix
    raspberrypi-eeprom
    k9s
    kubelogin-oidc
    vscodium
    ;

  nix-unstable = channels.latest.nix;
}
