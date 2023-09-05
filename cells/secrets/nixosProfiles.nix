{
  inputs,
  cell,
}: {
  secrets = _: {
    imports = [
      inputs.sops-nix.nixosModules.sops
      ./_common.nix
    ];

    sops.secrets = {
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
        key = "wireless290Env";
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
        key = "printer-tg-bot";
        sopsFile = ./sops/keys.yaml;
      };

      depsos-wg-pk = {
        key = "depsosWG";
        sopsFile = ./sops/keys.yaml;
      };
    };
  };

  minecraft = _: {
    sops.secrets = {
      minecraft-restic-pw-file = {
        key = "mc-restic-pw";
        sopsFile = ./sops/backups.yaml;
        mode = "0440";
        group = "minecraft-servers-backup";
      };

      minecraft-restic-env-file = {
        key = "mc-restic-env";
        sopsFile = ./sops/backups.yaml;
        mode = "0440";
        group = "minecraft-servers-backup";
      };
    };
  };
}
