{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
  };
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
  bee.pkgs = pkgs;

  system.stateVersion = "22.11";

  home-manager.users.truelecter = {
    services.vscode-server = {
      enable = true;
    };

    tl.services.win-gpg-agent = {
      enable = true;
      sorelayPath = "/mnt/d/Soft/Scoop/user/apps/win-gpg-agent/current/sorelay.exe";
      windowsSocketsPath = "D:/Soft/Scoop/user/apps/gpg/current/gnupg";
    };
  };
}
