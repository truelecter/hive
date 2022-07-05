{
  config,
  lib,
  pkgs,
  ...
}: {
  system.defaults.alf = {
    allowdownloadsignedenabled = 0;
    allowsignedenabled = 1;
    globalstate = 0;
    loggingenabled = 0;
    stealthenabled = 0;
  };
}
