## Populate ssh keys on nixos-generate installation
## WARNING: After first deploy, nixos will remove this files
{
  config,
  lib,
  pkgs,
  ...
}: let
  path = "/ssh/ssh_host_rsa_key";
  sshPrivateKeyPath = builtins.getEnv "SSH_PRIVATE_KEY_PATH_${lib.toUpper config.networking.hostName}";
  sshPrivateKey =
    if (builtins.stringLength sshPrivateKeyPath > 0)
    then (builtins.readFile sshPrivateKeyPath)
    else "";
in {
  systemd.services = lib.mkIf (builtins.stringLength sshPrivateKey > 0) {
    ssh-key-populate = {
      description = "Prepopulate ssh keys";

      before = ["basic.target"];
      after = ["local-fs.target" "sysinit.target"];
      wantedBy = ["basic.target"];

      serviceConfig = {
        ConditionPathNotExists = path;
        Type = "oneshot";
      };
      script = ''
        printf '%s' '${sshPrivateKey}' > ${path}
        chmod 600 ${path}
        ${pkgs.openssh}/bin/ssh-keygen -y -f ${path} > ${path}.pub
        chmod 644 ${path}
      '';
    };
  };
}
