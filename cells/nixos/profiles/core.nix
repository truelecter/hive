{
  inputs,
  common,
}: {
  lib,
  pkgs,
  ...
}: {
  imports = [
    common.core
    common.cachix
  ];

  #region nix options
  nix = {
    settings = {
      # Improve nix store disk usage
      auto-optimise-store = true;
      trusted-users = ["@wheel"];

      # This is just a representation of the nix default
      system-features = lib.mkDefault ["nixos-test" "benchmark" "big-parallel" "kvm"];
    };

    optimise.automatic = true;
  };
  #endregion

  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      # gptfdisk
      iputils
      usbutils
      util-linux
      pciutils
      ncdu
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

    settings = {
      # Use only public keys
      PasswordAuthentication = lib.mkForce false;
      KbdInteractiveAuthentication = lib.mkForce false;

      # root login is never welcome, except for remote builders
      PermitRootLogin = lib.mkForce "prohibit-password";
    };

    startWhenNeeded = lib.mkDefault true;
    openFirewall = lib.mkDefault false;
    hostKeys = [
      {
        type = "rsa";
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;

  # Disable by default (why is it enabled even lol)
  services.speechd.enable = lib.mkOverride 999 false;
}
