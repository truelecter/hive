{
  programs.direnv = {
    enable = builtins.trace "TODO: find a way to override direnv" true;
    nix-direnv = {
      enable = true;
    };
  };
}
