{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    suites.base
    profiles.common.networking.tailscale
    ({options, ...}: {
      wsl.enable = builtins.trace options.systemd true;

      imports = [
        inputs.nixos-wsl.nixosModules.wsl
      ];
    })
  ];

  networking.hostName = "wsl";

  # wsl = {
  #   enable = false;
  #   wslConf.automount.root = "/mnt";
  #   defaultUser = "truelecter";

  #   startMenuLaunchers = true;
  #   # docker-native.enable = true;
  #   docker-desktop.enable = true;
  # };

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
  };

  system.stateVersion = "22.11";
}
