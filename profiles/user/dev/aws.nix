{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    s5cmd
    awscli2
    ssm-session-manager-plugin
  ];
}
