{pkgs, ...}: {
  programs.vscode = {
    extensions = with pkgs.vscode-marketplace; [
      ms-python.python
      ms-python.vscode-pylance
    ];

    userSettings = {
      "python.defaultInterpreterPath" = "${pkgs.python39}/bin/python3";
    };
  };
}
