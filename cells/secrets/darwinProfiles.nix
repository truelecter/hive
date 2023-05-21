{
  inputs,
  cell,
}: {
  secrets = _: {
    imports = [
      inputs.sops-nix.darwinModules.sops
      ./_common.nix
    ];

    sops.secrets = {
      tailscale-key = {
        key = "tailscale";
        sopsFile = ./sops/keys.yaml;
        group = "wheel";
      };
    };
  };
}
