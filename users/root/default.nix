{
  hmUsers,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (lib) mkIf mkMerge;
in {
  # home-manager.users = {inherit (hmUsers) truelecter;};

  users.users.root = mkMerge [
    {
      gid = 0;
      uid = 0;
    }
    (mkIf isLinux {
      passwordFile = config.sops.secrets.root-password.path;
    })
  ];
}
