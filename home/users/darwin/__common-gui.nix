{username}: {
  pkgs,
  hmSuites,
  profiles,
  config,
  ...
}: let
  home = config.users.users.${username}.home;
in {
  home-manager.users.${username} = {
    imports = hmSuites.git ++
    [
      profiles.home.darwin.shell.iterm
      profiles.home.darwin.smart-card-fix
    ];

    home.stateVersion = "24.11";
  };

  system.defaults.dock.persistent-others = [];

  system.defaults.screencapture.location = "${home}/Documents/Captures";

  users.groups.keys.members = [username];

  home-manager.backupFileExtension = ".bak";
}
