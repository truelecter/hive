{
  inputs,
  cells,
}: {config, ...}: {
  services.tailscale = {
    enable = true;
    package = inputs.cells.common.overrides.tailscale;
  };
}
