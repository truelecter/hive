{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../../../secrets
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];
}
