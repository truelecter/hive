{
  inputs,
  cell,
}: let
  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;
    config.allowUnfree = true;
  };
in {
  inherit
    (latest)
    android-tools
    vscode
    alejandra
    nil
    terraform
    terraform-ls
    kubelogin-oidc
    minikube
    kubernetes-helm
    nixpkgs-fmt
    statix
    nix
    cachix
    nix-index
    _1password
    wrapHelm
    kubectl
    kubernetes-helmPlugins
    direnv
    amazon-ecr-credential-helper
    dive
    act
    nix-diff
    csvlens
    #
    
    tailscale
    ffmpeg_5-full
    ;

  # nix-diff = inputs.nix-diff.packages.default;
  nvfetcher = inputs.nvfetcher.packages.default;
}
