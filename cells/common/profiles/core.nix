{inputs, ...}: {
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) fileContents;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      binutils
      coreutils
      curl
      direnv
      delta
      bat
      thefuck
      dnsutils
      fd
      git
      bottom
      jq
      nix-index
      nmap
      ripgrep
      tmux
      whois
      zsh
      vim
      file
      gnused
      lsof
      lnav
      lsd
      iftop
      ncdu
    ];

    shellAliases = let
      # The `security.sudo.enable` option does not exist on darwin because
      # sudo is always available.
      ifSudo = lib.mkIf (isDarwin || config.security.sudo.enable);
    in {
      # quick cd
      ".." = "cd ..";
      "..." = "cd ../..";
      "cd.." = "cd ..";

      # internet ip
      # TODO: explain this hard-coded IP address
      myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

      mn = ''
        manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
      '';
      top = "btm";

      mkdir = "mkdir -pv";
      cp = "cp -iv";
      mv = "mv -iv";

      ll = "ls -l";
      la = "ls -la";

      path = "printf \\\"%b\\\\n\\\" \\\"\\\${PATH//:/\\\\\\n}\\\"";
      tm = "tmux new-session -A -s main";

      issh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null";
    };

    pathsToLink = ["/share/zsh"];

    variables = {
      # vim as default editor
      EDITOR = "vim";
      VISUAL = "vim";

      # Use custom `less` colors for `man` pages.
      LESS_TERMCAP_md = "$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)";
      LESS_TERMCAP_me = "$(tput sgr0 2> /dev/null)";

      # Don't clear the screen after quitting a `man` page.
      MANPAGER = "less -X";
    };
  };

  nix = {
    settings = {
      # Prevents impurities in builds
      sandbox = true;

      # Give root user and wheel group special Nix privileges.
      trusted-users = ["root" "@wheel"];

      keep-outputs = true;
      keep-derivations = true;
      builders-use-substitutes = true;
      experimental-features = ["flakes" "nix-command"];
      fallback = true;
      warn-dirty = false;
    };

    # Improve nix store disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    # Generally useful nix option defaults
    extraOptions = let
      GB = 1024 * 1024 * 1024;
    in ''
      min-free = ${toString (5 * GB)}
    '';

    nixPath = [
      "nixpkgs=${inputs.nixos}"
      "home-manager=${inputs.home}"
    ];

    registry = let
      inputs' = lib.filterAttrs (n: _: !(builtins.elem n ["cells" "self" "nixpkgs"])) inputs;
    in
      lib.mapAttrs (_: v: {flake = v;}) inputs';
  };
}
