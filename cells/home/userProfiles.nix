{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
  suites = with cell.homeProfiles; {
    base = [
      shell.direnv
      git
      shell.zsh
      shell.tmux
      shell.nvim
      home-manager-base
      ssh
    ];
    develop = [
      dev.aws
      dev.k8s
      dev.terraform
      dev.nix
    ];
    develop-gui = [
      dev.vscode
    ];
    android = [dev.android];
  };
in {
  workstation = {...}: {
    imports = with suites;
      l.flatten [
        base
        develop
        develop-gui
        android
      ];
  };
  minimal = {...}: {imports = suites.base;};
  server-dev = {...}: {
    imports = with suites;
      l.flatten [
        develop
        inputs.nixos-vscode-server.homeModules.default
      ];
  };
}
