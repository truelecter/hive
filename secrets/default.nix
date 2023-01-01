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

      xata-password-env = {
        key = "wireless291Env";
        sopsFile = ./sops/keys.yaml;
      };

      k3s-token = {
        key = "k3sToken";
        sopsFile = ./sops/keys.yaml;
      };

      k3s-depsos-external-ip = {
        key = "depsosK3sEnv";
        sopsFile = ./sops/external-ips.yaml;
      };

      moonraker-tg-bot = {
        owner = "moonraker-tg-bot";
        key = "printer-tg-bot";
        sopsFile = ./sops/keys.yaml;
      };
    })
  ];
}
