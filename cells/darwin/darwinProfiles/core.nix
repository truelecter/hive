{
  inputs,
  common,
}: {
  lib,
  pkgs,
  config,
  ...
}: {
  # TODO import all darwin modules exported in flake
  imports = [
    common.core
    common.cachix
    common.gui
  ];

  # https://github.com/LnL7/nix-darwin/issues/158#issuecomment-974598670
  programs.zsh.enable = true;
  programs.zsh.shellInit = ''export OLD_NIX_PATH="$NIX_PATH";'';
  programs.zsh.interactiveShellInit = ''
    if [ -n "$OLD_NIX_PATH" ]; then
      if [ "$NIX_PATH" != "$OLD_NIX_PATH" ]; then
        NIX_PATH="$OLD_NIX_PATH"
      fi
      unset OLD_NIX_PATH
    fi
  '';

  services.nix-daemon.enable = true;

  environment = {
    systemPackages = with pkgs; [
      m-cli
      terminal-notifier
      # Until https://github.com/NixOS/nixpkgs/pull/358321
      # duti
      darwin.iproute2mac
    ];

    # darwinConfig = "${self}/lib/compat";

    shellAliases = {
      nrb = "sudo darwin-rebuild switch --flake";

      ls = "ls -G";

      hide-desktop-icons = "defaults write com.apple.finder CreateDesktop -bool false && killall Finder";
      show-desktop-icons = "defaults write com.apple.finder CreateDesktop -bool true && killall Finder";

      empty-trash = "sudo rm -frv /Volumes/*/.Trashes; \
        sudo rm -frv ~/.Trash; \
        sudo rm -frv /private/var/log/asl/*.asl; \
        sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'";

      clear-dns-cache = "sudo dscacheutil -flushcache; \
        sudo killall -HUP mDNSResponder";
    };

    variables = {
      LSCOLORS = "gxfxcxdxcxegedabagccbd";
    };
  };

  nix = {
    nixPath = [
      # TODO: This entry should be added automatically via FUP's
      # `nix.linkInputs` and `nix.generateNixPathFromInputs` options, but
      # currently that doesn't work because nix-darwin doesn't export packages,
      # which FUP expects.
      #
      # This entry should be removed once the upstream issues are fixed.
      #
      # https://github.com/LnL7/nix-darwin/issues/277
      # https://github.com/gytis-ivaskevicius/flake-utils-plus/issues/107
      "darwin=/etc/nix/inputs/darwin"
    ];

    settings = {
      # Administrative users on Darwin are part of this group.
      trusted-users = ["@admin"];

      sandbox = "relaxed";
    };

    configureBuildUsers = true;
  };

  sops.gnupg.sshKeyPaths = lib.mkDefault [
    "/etc/ssh/ssh_host_rsa_key"
  ];

  users = {
    knownGroups = ["keys"];
    groups.keys = {
      name = "keys";
      gid = 30001;
      members = ["root"];
      description = "Required by sops-nix";
    };
  };

  homebrew = {
    enable = true;
    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask-versions"
    ];
    casks = [
      "iterm2"
      "launchcontrol"
      "alt-tab"
    ];
  };

  system.defaults = {
    CustomUserPreferences = {
      "com.lwouis.alt-tab-macos" = lib.importJSON ./_files/alt-tab.plist.json;
    };
  };

  system.systemBuilderArgs = lib.mkIf (config.nix.settings.sandbox == "relaxed") {
    sandboxProfile = ''
      (allow file-read* file-write* process-exec mach-lookup (subpath "${builtins.storeDir}"))
    '';
  };
}
