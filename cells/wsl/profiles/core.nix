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
  imports = [
    nixos.core
  ];

  bee.wsl = lib.mkDefault inputs.nixos-wsl;

  wsl = {
    # enable = false;
    wslConf.automount.root = "/mnt";

    startMenuLaunchers = true;
    # docker-native.enable = true;
    # docker-desktop.enable = true;
  };

  environment.systemPackages = let
    inherit (pkgs.linuxPackages) usbip;
  in [
    usbip
  ];
}
