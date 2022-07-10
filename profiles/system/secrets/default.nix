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
      ./../../../secrets
    ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  sops.gnupg.sshKeyPaths = lib.mkIf isDarwin [
    "/etc/ssh/ssh_host_rsa_key"
  ];

  users = lib.mkIf isDarwin {
    knownGroups = ["keys"];
    groups.keys = {
      name = "keys";
      gid = 30001;
      members = [ "root" "andrii.panasiuk" ];
      description = "Required by sops-nix";
    };
  };
}
