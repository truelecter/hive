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
    neovim-unwrapped
    terraform-lss
    k9s
    rnix-lsp
    ffmpeg_5
    klipper
    klipper-flash
    klipper-firmware
    klipper-genconf
    ;
}
