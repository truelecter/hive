{...}: let
  spoolmanServer = "sirius:7912";
in {
  services.moonraker.settings.spoolman = {
    server = "http://${spoolmanServer}";
    sync_rate = 5;
  };
}
