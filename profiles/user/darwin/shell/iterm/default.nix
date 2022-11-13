{
  self,
  config,
  lib,
  pkgs,
  ...
}: {
  home.file.itermDynamicProfile = {
    source = ./files/profile.json;
    target = "Library/Application Support/iTerm2/DynamicProfiles/profile.json";
  };
}
