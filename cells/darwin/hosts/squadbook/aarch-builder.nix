{
  pkgs,
  lib,
  ...
}: {
  nix.linux-builder = {
    enable = true;
  };
}
