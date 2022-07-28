{
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  inherit (lib) mkMerge mkIf;
in {
  sops.secrets = mkMerge [
    # Common secrets
    {}
    # Darwin secrets
    (mkIf isDarwin {
      tailscale-key = {
        key = "tailscale";
        sopsFile = ./sops/keys.yaml;
        group = "wheel";
      };
    })
    # NixOS secrets
    (mkIf isLinux {
      root-password = {
        key = "root";
        sopsFile = ./sops/user-passwords.yaml;
        neededForUsers = true;
      };

      tailscale-key = {
        key = "tailscale";
        sopsFile = ./sops/keys.yaml;
      };
    })
  ];
}
