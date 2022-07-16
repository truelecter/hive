{hmUsers, ...}: {
  home-manager.users."andrii.panasiuk" = hmUsers."andrii.panasiuk";
  home-manager.backupFileExtension = ".bak";

  users.groups.keys.members = ["andrii.panasiuk"];
}
