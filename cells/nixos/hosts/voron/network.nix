{
  systemd.network.enable = true;
  networking.useDHCP = true;
  networking.useNetworkd = false;
  services.resolved.enable = true;
}
