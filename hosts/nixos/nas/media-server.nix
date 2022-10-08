{
  config,
  pkgs,
  ...
}: {
  disabledModules = ["nixos/services/misc/jellyfin.nix"];

  services.jellyfin = {
    enable = true;
    group = "share";
    openFirewall = true;
  };
}
