{
  hmUsers,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;
  inherit (lib) mkIf mkMerge;
in {
  # home-manager.users = {inherit (hmUsers) truelecter;};

  users.users.root = mkMerge [
    {
      uid = 0;
    }
    (mkIf isDarwin {
      gid = 0;
    })
    (mkIf isLinux {
      passwordFile = config.sops.secrets.root-password.path;
    })
  ];
}
