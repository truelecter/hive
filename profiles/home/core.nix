{pkgs, ...}: {
  xdg.enable = true;

  programs = {
    lsd = {
      enable = true;
      enableAliases = true;
    };

    bat = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    bottom
    nix-tree
  ];

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };
}
