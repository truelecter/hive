channels: final: prev: {
  __dontExport = true; # overrides clutter up actual creations

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
    k9s
    rnix-lsp
    ffmpeg_5
    klipper-flash
    klipper-firmware
    klipper-genconf
    statix
    raspberrypi-eeprom
    k3s
    containerd
    cni
    cni-plugins
    cni-plugin-flannel
    ;
}
