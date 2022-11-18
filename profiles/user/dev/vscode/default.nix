{
  pkgs,
  lib,
  ...
}: let
  chromium = pkgs.stdenv.mkDerivation rec {
    name = "Chromium";
    version = "101.0.4904.0";
    revision = "973630";
    src = builtins.fetchurl {
      url = "https://storage.googleapis.com/chromium-browser-snapshots/Mac_Arm/${revision}/chrome-mac.zip";
      sha256 = "16qk18xydaf69xwz5shdz3p4h4ggrcgcmman3dhd2xbhnksf1cgd";
    };
    sourceRoot = "chrome-mac/Chromium.app";
    buildInputs = with pkgs; [undmg unzip];
    phases = ["installPhase"];
    installPhase = ''
      mkdir -p "$out/Applications/${name}.app"
      cp -pR * "$out/Applications/${name}.app"
    '';
  };
in {
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
      # kamadorueda.alejandra
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
      # yzane.markdown-pdf
      roscop.activefileinstatusbar
      PKief.material-icon-theme
      bungcip.better-toml
      mads-hartmann.bash-ide-vscode
    ];
    userSettings =
      lib.recursiveUpdate
      (builtins.fromJSON (builtins.readFile ./settings.json))
      {
        "python.defaultInterpreterPath" = "${pkgs.python39}/bin/python3";
        # "markdown-pdf.executablePath" = "${chromium.outPath}/Applications/Chromium.app/Contents/MacOS/Chromium";
      };
  };

  home.shellAliases = {
    code = "codium";
  };
}
