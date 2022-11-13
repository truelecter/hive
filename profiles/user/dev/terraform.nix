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
    "terraform.languageServer.path" = "${pkgs.terraform-ls}/bin/terraform-ls";
    "terraform.languageServer.terraform.path" = "${pkgs.terraform}/bin/terraform";
    "terraform.codelens.referenceCount" = true;
  };

  home.packages = with pkgs; [
    tfenv
    terragrunt
  ];
}
