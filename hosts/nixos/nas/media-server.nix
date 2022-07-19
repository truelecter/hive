{
  config,
  pkgs,
  ...
}: {
  services.jellyfin = {
    enable = true;
    group = "share";
    openFirewall = true;
  };
}
