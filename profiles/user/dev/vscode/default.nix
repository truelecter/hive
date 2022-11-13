{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # TODO split extensions based on active modules
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      coolbear.systemd-unit-file
      davidanson.vscode-markdownlint
      pkgs.vscode-extensions."4ops".packer
      apollographql.vscode-apollo
      christian-kohler.path-intellisense
      davidnussio.vscode-jq-playground
      dbaeumer.vscode-eslint
      donjayamanne.githistory
      eamodio.gitlens
      editorconfig.editorconfig
      eg2.vscode-npm-script
      erd0s.terraform-autocomplete
      golang.go
      graphql.vscode-graphql
      graphql.vscode-graphql-execution
      graphql.vscode-graphql-syntax
      hashicorp.terraform
      ipedrazas.kubernetes-snippets
      ivory-lab.jenkinsfile-support
      jnoortheen.nix-ide
      jq-syntax-highlighting.jq-syntax-highlighting
      kamadorueda.alejandra
      lunuan.kubernetes-templates
      maarti.jenkins-doc
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      natqe.reload
      nicolasvuillamy.vscode-groovy-lint
      octref.vetur
      plorefice.devicetree
      redhat.java
      redhat.vscode-commons
      redhat.vscode-xml
      redhat.vscode-yaml
      tim-koehler.helm-intellisense
      whi-tw.klipper-config-syntax
      xadillax.viml
      yzane.markdown-pdf
      roscop.activefileinstatusbar
      PKief.material-icon-theme
    ];
    userSettings =
      lib.recursiveUpdate
      (builtins.fromJSON (builtins.readFile ./settings.json))
      {
        "python.defaultInterpreterPath" = "${pkgs.python39}/bin/python3";
      };
  };
}
