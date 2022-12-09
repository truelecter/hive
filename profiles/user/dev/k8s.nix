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

  home.packages = let
    helm-wapped = pkgs.wrapHelm pkgs.kubernetes-helm {plugins = [pkgs.kubernetes-helmPlugins.helm-diff];};
  in
    with pkgs; [
      kubectl
      k9s
      dive
      kubelogin-oidc
      helm-wapped
      minikube
    ];
}
