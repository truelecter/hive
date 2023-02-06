{
  self,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.vscode.userSettings = {
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      "nil" = {
        "formatting" = {
          "command" = ["alejandra"];
        };
      };
    };
    "nix.enableLanguageServer" = true;
    "[nix]" = {"editor.formatOnSave" = true;};
  };

  home.packages = with pkgs; [
    rnix-lsp
    alejandra
    nil
  ];
}
