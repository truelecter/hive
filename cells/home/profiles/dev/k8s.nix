{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common) overrides packages;
in
  {pkgs, ...}: {
    programs.vscode.userSettings = {
      "vscode-kubernetes.kubectl-path" = "${overrides.kubectl}/bin/kubectl";
      "vscode-kubernetes.helm-path" = "${overrides.kubernetes-helm}/bin/helm";
      "vscode-kubernetes.log-viewer.follow" = true;
      # "vs-kubernetes" = {
      #   "vscode-kubernetes.kubectl-path" = "${pkgs.kubectl}/bin/kubectl";
      #   "vscode-kubernetes.helm-path" = "${pkgs.kubernetes-helm}/bin/helm";
      #   "vscode-kubernetes.log-viewer.follow" = true;
      # };
    };

    home.packages = let
      helm-wrapped = overrides.wrapHelm overrides.kubernetes-helm {plugins = [overrides.kubernetes-helmPlugins.helm-diff];};
    in
      with pkgs; [
        kubectl
        packages.k9s
        dive
        overrides.kubelogin-oidc
        helm-wrapped
        overrides.minikube
      ];
  }
