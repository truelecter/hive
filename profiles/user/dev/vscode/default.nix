{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    # enableExtensionUpdateCheck = false;
    # enableUpdateCheck = false;
    package = pkgs.vscodium;
    # for now
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bbenoist.nix
      coolbear.systemd-unit-file
      davidanson.vscode-markdownlint
      pkgs.vscode-extensions."4ops".packer
      apollographql.vscode-apollo
      # christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      # coolbear.systemd-unit-file
      # cschlosser.doxdocgen
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
      # iterative.dvc
      ivory-lab.jenkinsfile-support
      # janjoerke.jenkins-pipeline-linter-connector
      # jeff-hykin.better-cpp-syntax
      jnoortheen.nix-ide
      # josetr.cmake-language-support-vscode
      jq-syntax-highlighting.jq-syntax-highlighting
      kamadorueda.alejandra
      # lunuan.kubernetes-templates
      # maarti.jenkins-doc
      ms-azuretools.vscode-docker
      # ms-dotnettools.csharp no darwin support
      # ms-dotnettools.vscode-dotnet-runtime
      ms-kubernetes-tools.vscode-kubernetes-tools
      # ms-python.isort
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      # ms-toolsai.jupyter-keymap
      # ms-toolsai.jupyter-renderers
      # ms-toolsai.vscode-jupyter-cell-tags
      # ms-toolsai.vscode-jupyter-slideshow
      # ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      # ms-vscode-remote.remote-wsl
      # ms-vscode-remote.vscode-remote-extensionpack
      # ms-vscode.cmake-tools
      # ms-vscode.cpptools no darwin support
      # ms-vscode.cpptools-extension-pack
      # ms-vscode.cpptools-themes
      # ms-vscode.makefile-tools
      natqe.reload
      # nelite.vscode-anime-motivator
      nicolasvuillamy.vscode-groovy-lint
      octref.vetur
      # platformio.platformio-ide
      plorefice.devicetree
      redhat.java
      # redhat.vscode-commons
      # redhat.vscode-xml
      redhat.vscode-yaml
      # tabeyti.jenkins-jack
      tim-koehler.helm-intellisense
      # twxs.cmake
      # visualstudioexptteam.intellicode-api-usage-examples
      # visualstudioexptteam.vscodeintellicode
      # vscjava.vscode-java-debug
      # vscjava.vscode-java-dependency
      # vscjava.vscode-java-pack
      # vscjava.vscode-java-test
      # vscjava.vscode-maven
      whi-tw.klipper-config-syntax
      xadillax.viml
      yzane.markdown-pdf
      roscop.activefileinstatusbar
    ];
    userSettings = {
      "update.mode" = "none";
      "extensions.autoCheckUpdates" = false;
      "terminal.integrated.macOptionClickForcesSelection" = true;
      "terminal.integrated.shell.osx" = "/bin/zsh";
    };
  };
}
