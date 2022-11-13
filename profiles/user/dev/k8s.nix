{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode.userSettings = {
    "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
    "vscode-kubernetes.helm-path" = "${pkgs.kubernetes-helm}/bin/helm";
    "vscode-kubernetes.log-viewer.follow" = true;
    # "vs-kubernetes" = {
    #   "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
    #   "vscode-kubernetes.helm-path" = "${pkgs.kubernetes-helm}/bin/helm";
    #   "vscode-kubernetes.log-viewer.follow" = true;
    # };
  };

  home.packages = with pkgs; [
    kubectl
    k9s
    dive
    kubelogin-oidc
    kubernetes-helm
  ];
}
