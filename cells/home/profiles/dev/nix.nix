{
  inputs,
  cell,
}: {pkgs, ...}: let
  vs-exts = inputs.cells.common.overrides.vscode-marketplace;
in {
  programs.vscode = {
    extensions = with vs-exts; [
      arrterian.nix-env-selector
      bbenoist.nix
      jnoortheen.nix-ide
    ];

    userSettings = {
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
  };

  home.packages = with inputs.cells.common.overrides; [
    alejandra
    nil
  ];
}
