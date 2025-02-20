{pkgs, ...}: {
  home-manager.users.truelecter.programs.jetbrains-remote = {
    enable = true;
    ides = with pkgs.jetbrains; [webstorm];
  };
}
