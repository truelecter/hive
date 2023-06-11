{
  inputs,
  common,
  nixos,
}: {
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  wsl = {
    # docker-native.enable = true;
    docker-desktop.enable = true;
  };
}
