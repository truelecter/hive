{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    oci-cli
  ];
}
