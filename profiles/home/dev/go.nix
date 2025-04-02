{pkgs, ...}: {
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      golang.go
    ];
  };
}
