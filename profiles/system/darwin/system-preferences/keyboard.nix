{
  config,
  lib,
  pkgs,
  ...
}: {
  system.defaults.NSGlobalDomain = {
    # Use F1, F2, etc. keys as standard function keys.
    "com.apple.keyboard.fnState" = true;
  };

  system.keyboard = {
    enableKeyMapping = false;
  };
}
