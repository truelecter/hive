{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  homebrew.casks = [
    "prismlauncher"
    "zulu8"
    "zulu17"
  ];
}
