{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  ...
}: let
  opkgs = inputs.cells.common.overrides;
in {
  programs.vscode = {
    enable = true;
    package = opkgs.vscode;
    # TODO split extensions based on active modules
    extensions = with opkgs.vscode-marketplace; [
      coolbear.systemd-unit-file
      davidanson.vscode-markdownlint
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      donjayamanne.githistory
      eamodio.gitlens
      editorconfig.editorconfig
      ivory-lab.jenkinsfile-support
      jq-syntax-highlighting.jq-syntax-highlighting
      natqe.reload
      nicolasvuillamy.vscode-groovy-lint
      plorefice.devicetree
      redhat.vscode-commons
      redhat.vscode-xml
      redhat.vscode-yaml
      whi-tw.klipper-config-syntax
      roscop.activefileinstatusbar
      pkief.material-icon-theme
      tamasfe.even-better-toml
      mads-hartmann.bash-ide-vscode
      ericadamski.carbon-now-sh
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      mkhl.direnv
      systemticks.c4-dsl-extension
      likec4.likec4-vscode
    ];
    userSettings = builtins.fromJSON (builtins.readFile ./_files/vscode-settings.json);
  };
}
