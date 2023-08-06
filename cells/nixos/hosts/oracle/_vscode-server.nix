{pkgs, ...}: {
  home-manager.users.truelecter = {
    services.vscode-server = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
  ];
}
