{pkgs, ...}: let
  helm-wrapped = pkgs.wrapHelm pkgs.kubernetes-helm {plugins = [pkgs.kubernetes-helmPlugins.helm-diff];};
in {
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      lunuan.kubernetes-templates
      ipedrazas.kubernetes-snippets
      ms-kubernetes-tools.vscode-kubernetes-tools
      tim-koehler.helm-intellisense
    ];

    userSettings = {
      "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
      "vscode-kubernetes.helm-path" = "${helm-wrapped}/bin/helm";
      "vscode-kubernetes.log-viewer.follow" = true;
      # "vs-kubernetes" = {
      #   "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
      #   "vscode-kubernetes.helm-path" = "${pkgs.kubernetes-helm}/bin/helm";
      #   "vscode-kubernetes.log-viewer.follow" = true;
      # };
    };
  };

  home.packages = with pkgs; [
    helm-wrapped

    kubectl

    k9s

    dive
    kubelogin-oidc
    minikube
  ];
}
