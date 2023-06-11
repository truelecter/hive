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
    profiles.docker
    profiles.common.networking.tailscale
  ];

  networking.hostName = "tl-wsl";

  wsl = {
    defaultUser = "truelecter";
    nativeSystemd = true;
  };

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
  };

  system.stateVersion = "22.11";
}
