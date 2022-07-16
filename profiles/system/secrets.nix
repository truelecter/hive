{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  imports =
    [
      ./../../secrets
    ];

  environment.systemPackages = with pkgs; [
    sops
  ];
}
