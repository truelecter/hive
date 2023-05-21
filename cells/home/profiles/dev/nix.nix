{
  inputs,
  cell,
}: {pkgs, ...}: {
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

  home.packages = with inputs.cells.common.overrides; [
    rnix-lsp
    alejandra
    nil
  ];
}
