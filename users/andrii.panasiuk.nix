{hmUsers, ...}: let
  home = "/Users/andrii.panasiuk";
in {
  users.users."andrii.panasiuk".home = home;
  home-manager.users."andrii.panasiuk" = hmUsers."andrii.panasiuk";
  home-manager.backupFileExtension = ".bak";

  users.groups.keys.members = ["andrii.panasiuk"];

  # The filesystem path to which screencaptures should be written.
  system.defaults.screencapture.location = "${home}/Documents/Captures";
}
