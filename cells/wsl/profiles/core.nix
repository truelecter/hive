{
  inputs,
  common,
  nixos,
}: {
  lib,
  pkgs,
  ...
}: {
  imports = [
    nixos.core
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    # defaultUser = "truelecter";

    startMenuLaunchers = true;
    # docker-native.enable = true;
    docker-desktop.enable = true;
  };
}
