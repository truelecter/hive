{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode.userSettings = {
  };

  home.packages = with pkgs; [
    kubectl
    k9s
    dive
    kubelogin-oidc
    kubernetes-helm
  ];
}
