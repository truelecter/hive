{
  inputs,
  cell,
}: let
  latest = import inputs.latest {
    inherit (inputs.nixpkgs) system;

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];

    config.allowUnfree = true;
  };

  master = import inputs.nixpkgs-master {
    inherit (inputs.nixpkgs) system;

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];

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
    _1password-cli
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
    ffmpeg_5-full
    vscode-marketplace
    open-vsx
    ;

  inherit (master) tailscale;

  # nix-diff = inputs.nix-diff.packages.default;
  nvfetcher = inputs.nvfetcher.packages.default;
}
