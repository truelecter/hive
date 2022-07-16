{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  services.tailscale.enable = true;

  tl.services.tailscale-autoconnect = {
    enable = true;
    authFile = config.sops.secrets.tailscale-key.path;
  };
}
