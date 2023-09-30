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
    docker-desktop.enable = true;
  };
}
