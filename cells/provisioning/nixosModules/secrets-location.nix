{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types;

  cfg = config.tl.provision.secrets;
in {
  options.tl.provision.secrets = {
    secretsPresent = lib.mkOption {
      type = types.bool;
      default = cfg.unencryptedBase != null && cfg.expectedSecrets != [];
      readOnly = true;
      description = "Whether user set a path to the secrets";
    };

    unencryptedBase = lib.mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "/boot/secrets/";
      description = "Directory where unencrypted secrets are located";
    };

    # TODO: actually use this
    expectedSecrets = lib.mkOption {
      type = types.listOf types.str;
      default = [];
      example = lib.literalExpression ''["wifi-auth" "tailscale-key"]'';
      description = "Secrets that are expected to be present. May be treated as 'feature-flags'";
    };

    # TODO add auto-purge
  };
}
