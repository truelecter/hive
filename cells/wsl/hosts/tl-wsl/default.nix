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
    profiles.vscode-server

    inputs.nixos-vscode-server.nixosModules.default
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

  home-manager.users.truelecter.services.vscode-server = {
    enable = true;
  };

  system.stateVersion = "22.11";
}
