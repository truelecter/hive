{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  ...
}: let
  vs-exts = inputs.nix-vscode-extensions.extensions.vscode-marketplace;
in {
  programs.vscode = {
    extensions = with vs-exts; [
      golang.go
    ];
  };
}
