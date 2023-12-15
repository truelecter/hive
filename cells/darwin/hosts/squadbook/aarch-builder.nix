{
  pkgs,
  lib,
  ...
}: {
  nix.linux-builder = {
    enable = true;
    maxJobs = 8;
  };
}
