{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  # programs.tmux.shell = lib.mkForce "${pkgs.zsh}/bin/zsh";

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;

    history = {
      extended = true;
      ignoreDups = true;
      ignorePatterns = ["&" "[bf]g" "c" "clear" "history" "exit" "q" "pwd" "* --help"];
      ignoreSpace = true;
      share = false;
    };

    oh-my-zsh = {
      enable = true;

      plugins = [
        # "aws"
        # "kubectl"
        # "kube-ps1"
        "git"
        "tmux"
      ];
    };

    initExtraBeforeCompInit = ''
      (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

      # p10k instant prompt
      P10K_INSTANT_PROMPT="''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      [[ ! -r "$P10K_INSTANT_PROMPT" ]] || source "$P10K_INSTANT_PROMPT"

      (( ''${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
    '';

    initExtra = ''
      [[ -f "$HOME/.sh.local" ]] && source "$HOME/.sh.local"
      export GPG_TTY=$TTY
    '';

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    localVariables = {
      ZSH_DISABLE_COMPFIX = "true";
      COMPLETION_WAITING_DOTS = "true";
      DISABLE_UNTRACKED_FILES_DIRTY = "true";
      HIST_STAMPS = "dd.mm.yyyy";
    };
  };
}
