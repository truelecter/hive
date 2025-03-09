{
  inputs,
  cell,
}: {pkgs, ...}: let
  inherit (inputs.cells.common) overrides packages;
  vs-exts = inputs.cells.common.overrides.vscode-marketplace;
  helm-wrapped = overrides.wrapHelm overrides.kubernetes-helm {plugins = [overrides.kubernetes-helmPlugins.helm-diff];};
in {
  programs.vscode = {
    extensions = with vs-exts; [
      lunuan.kubernetes-templates
      ipedrazas.kubernetes-snippets
      ms-kubernetes-tools.vscode-kubernetes-tools
      tim-koehler.helm-intellisense
    ];

    userSettings = {
      "vscode-kubernetes.kubectl-path" = "${overrides.kubectl}/bin/kubectl";
      "vscode-kubernetes.helm-path" = "${helm-wrapped}/bin/helm";
      "vscode-kubernetes.log-viewer.follow" = true;
      # "vs-kubernetes" = {
      #   "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
      #   "vscode-kubernetes.helm-path" = "${pkgs.kubernetes-helm}/bin/helm";
      #   "vscode-kubernetes.log-viewer.follow" = true;
      # };
    };
  };

  home.packages = [
    helm-wrapped

    pkgs.kubectl

    packages.k9s

    overrides.dive
    overrides.kubelogin-oidc
    overrides.minikube
  ];
}
