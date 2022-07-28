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
    ;
}
