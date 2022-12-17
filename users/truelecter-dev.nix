{
  hmUsers,
  pkgs,
  ...
}: {
  imports = [
    ./truelecter.nix
  ];

  home-manager.users.truelecter.services.vscode-server.enable = true;
}
