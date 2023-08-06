{
  config,
  options,
  ...
}: let
  cfg = config.services.klipper;
in {
  disabledModules = ["services/misc/klipper.nix"];

  options = {};
}
