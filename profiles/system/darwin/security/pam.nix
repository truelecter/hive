{
  config,
  lib,
  pkgs,
  ...
}: {
  security.pam.enableSudoTouchIdAuthWithReattach = true;
}
