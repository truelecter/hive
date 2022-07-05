{
  config,
  lib,
  pkgs,
  ...
}: {
  security.pam.enableSudoTouchIdAuth = true;
}
