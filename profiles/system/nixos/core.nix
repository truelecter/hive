{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ../common.nix
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
      hexdump
      pciutils
    ];
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

  services.openssh = {
    enable = lib.mkDefault true;

    # Use only public keys
    passwordAuthentication = lib.mkForce false;
    kbdInteractiveAuthentication = lib.mkForce false;

    # root login is never welcome, except for remote builders
    permitRootLogin = lib.mkForce "prohibit-password";

    startWhenNeeded = lib.mkDefault true;
    openFirewall = lib.mkDefault false;
    hostKeys = [
      {
        type = "rsa";
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
      }
    ];
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;
}
