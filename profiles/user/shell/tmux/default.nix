{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;

    clock24 = true;
    keyMode = "vi";
    shortcut = "b";
    terminal = "screen-256color";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        # extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.zsh.localVariables = {
    # ZSH_TMUX_AUTOSTART = "true";
  };
}
