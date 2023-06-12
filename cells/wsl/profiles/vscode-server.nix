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
  environment.systemPackages = with pkgs; [
    wget
  ];
}
