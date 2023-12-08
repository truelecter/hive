{
  inputs,
  cell,
}: {pkgs, ...}: let
  vs-exts = inputs.nix-vscode-extensions.extensions.vscode-marketplace;
in {
  programs.vscode = {
    extensions = with vs-exts; [
      ms-python.python
      ms-python.vscode-pylance
    ];

    userSettings = {
      "python.defaultInterpreterPath" = "${pkgs.python39}/bin/python3";
    };
  };
}
