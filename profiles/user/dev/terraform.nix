{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.vscode.userSettings = {
    "[terraform]" = {
      "editor.defaultFormatter" = "hashicorp.terraform";
      "editor.formatOnSave" = true;
    };
    "terraform.experimentalFeatures.validateOnSave" = true;
  };

  home.packages = with pkgs; [
    tfenv
    terragrunt
  ];
}
