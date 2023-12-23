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
      rust-lang.rust-analyzer
      probe-rs.probe-rs-debugger
      zixuanwang.linkerscript
    ];
    # userSettings = {
    #   "rust-analyzer.cargo.target" = "thumbv7em-none-eabihf";
    #   "rust-analyzer.cargo.extraArgs" = [
    #     "--target"
    #     "thumbv7em-none-eabihf"
    #   ];
    #   "rust-analyzer.check.allTargets" = false;
    # };
  };
}
