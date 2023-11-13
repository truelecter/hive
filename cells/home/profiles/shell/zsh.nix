_: {
  lib,
  pkgs,
  ...
}: {
  # programs.tmux.shell = lib.mkForce "${pkgs.zsh}/bin/zsh";

  programs.direnv = {
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

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
        # "thefuck"
      ];
    };

    initExtraBeforeCompInit = ''
      export ZSH_COMPDUMP=$XDG_CACHE_HOME/oh-my-zsh/.zcompdump-$HOST

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
        src = lib.cleanSource ./_files/p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        file = "F-Sy-H.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.66";
          sha256 = "sha256-uoLrXfq31GvfHO6GTrg7Hus8da2B4SCM1Frc+mRFbFc=";
        };
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
