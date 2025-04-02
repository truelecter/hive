{
  config,
  pkgs,
  ...
}: {
  # disabledModules = ["nixos/services/misc/jellyfin.nix"];

  services.jellyfin = {
    enable = true;
    group = "share";
    openFirewall = true;
  };

  systemd.services.jellyfin.serviceConfig = {
    BindPaths = "/tmp/cache";
  };
}
