{
  inputs,
  common,
  nixos,
  cell,
}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    cell.nixosModules.provision
  ];

  services.tailscale = {
    enable = true;
    package = inputs.cells.common.overrides.tailscale;
  };

  tl.services.tailscale-autoconnect = {
    enable = config.tl.provision.secrets.secretsPresent;
    authFile = lib.mkDefault "${config.tl.provision.secrets.unencryptedBase}/tailscale-key";
  };

  networking.firewall.enable = false;
}
