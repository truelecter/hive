{
  inputs,
  cell,
}: {
  secrets = _: {
    imports = [
      inputs.sops-nix.darwinModules.sops
      ./_common.nix
    ];
  };
}
