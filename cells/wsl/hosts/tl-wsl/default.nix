{
  inputs,
  suites,
  profiles,
  overlays,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      overlays.wsl-nvidia-docker
    ];
  };
in {
  imports = [
    suites.base
    profiles.docker
    profiles.nvidia
    profiles.vscode-server

    profiles.common.networking.tailscale
    profiles.common.remote-builders.x86
    profiles.common.remote-builders.aarch

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
      # sockets.ssh.assuan = true;
      sockets = {
        gpg.enable = false;
        extra.wslRelativePath = "S.gpg-agent";
      };
      relayPath = "/mnt/d/Soft/wsl2-ssh-bridge.exe";
      windowsSocketsPath = "D:/Soft/Scoop/user/apps/gnupg/current/gnupg";
    };
  };
}
