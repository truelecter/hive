{
  self,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.vscode.userSettings = {
    "nix.serverPath" = "${pkgs.nil}/bin/nil";
    "nix.enableLanguageServer" = true;
    "nix.formatterPath" = "${pkgs.alejandra}/bin/alejandra";
  };

  home.packages = with pkgs; [
    rnix-lsp
    alejandra
    nil
  ];
}
