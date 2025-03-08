{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  ...
}: let
  vs-exts = inputs.cells.common.overrides.vscode-marketplace;
in {
  programs.vscode = {
    extensions = with vs-exts; [
      golang.go
    ];
  };
}
