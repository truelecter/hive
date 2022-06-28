{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./common.nix
  ];

  #region nix options
  nix = {
    # Improve nix store disk usage
    autoOptimiseStore = true;
    optimise.automatic = true;
    allowedUsers = ["root @wheel"];
    # This is just a representation of the nix default
    systemFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
  };
  #endregion

  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ];

    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  #region Common system defaults
  time.timeZone = "Europe/Kiev";

  users.mutableUsers = lib.mkDefault false;
  security.sudo.enable = lib.mkForce true;
  security.sudo.wheelNeedsPassword = lib.mkForce false;

  console = {
    font = "Lat2-Terminus16";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  #endregion

  programs.bash = {
    # Enable starship
    promptInit = ''
      eval "$(${pkgs.starship}/bin/starship init bash)"
    '';
    # Enable direnv, a tool for managing shell environments
    interactiveShellInit = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
  };

  services.openssh = {
    enable = lib.mkDefault true;
    passwordAuthentication = lib.mkForce false;
    startWhenNeeded = lib.mkDefault true;
    kbdInteractiveAuthentication = lib.mkForce false;
    permitRootLogin = lib.mkForce "no";
    openFirewall = lib.mkDefault false;
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
