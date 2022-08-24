{
  self,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    rnix-lsp
    alejandra
  ];
}
