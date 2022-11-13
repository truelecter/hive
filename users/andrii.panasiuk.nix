{hmUsers, ...}: {
  users.users."andrii.panasiuk".home = "/Users/andrii.panasiuk";
  home-manager.users."andrii.panasiuk" = hmUsers."andrii.panasiuk";
  home-manager.backupFileExtension = ".bak";

  users.groups.keys.members = ["andrii.panasiuk"];
}
