{
  inputs,
  common,
  nixos,
}: {
  lib,
  pkgs,
  ...
}: let
  tailscale-key = builtins.getEnv "TL_TAILSCALE_PROVISIONING_KEY";
in {
  services.tailscale = {
    enable = true;
    package = inputs.cells.common.overrides.tailscale;
  };

  tl.services.tailscale-autoconnect = {
    enable = true;
    authFile = pkgs.writeTextFile {
      name = "tailscale-key";
      text = tailscale-key;
    };
  };

  networking.firewall.enable = false;
}
