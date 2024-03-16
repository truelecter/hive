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
    #
    
    tailscale
    ffmpeg_5-full
    ;

  nvfetcher = inputs.nvfetcher.packages.default;
}
