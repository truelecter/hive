{
  inputs,
  cells,
}: {config, ...}: {
  services.tailscale = {
    enable = true;
    package = inputs.cells.common.overrides.tailscale;
  };

  tl.services.tailscale-autoconnect = {
    enable = true;
    authFile = config.sops.secrets.tailscale-key.path;
  };
}
