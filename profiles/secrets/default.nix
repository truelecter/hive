{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../../secrets/secrets.nix
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];
}
