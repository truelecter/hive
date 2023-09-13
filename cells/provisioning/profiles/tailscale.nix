{
  inputs,
  common,
  nixos,
}: {
  lib,
  pkgs,
  ...
}: {
  services.tailscale = {
    enable = true;
    package = inputs.cells.common.overrides.tailscale;
  };

  networking.firewall.enable = false;
}
