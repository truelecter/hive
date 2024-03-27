{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std haumea;
  l = nixpkgs.lib // builtins;
  profiles = cell.darwinProfiles;
  users = inputs.cells.home.users.darwin;
in
  # with cell.darwinProfiles;
  {
    base = _: {
      imports = with profiles; [
        core
        security.pam
        security.one-password
        messengers
        inputs.cells.secrets.darwinProfiles.secrets
      ];
    };

    editors = _: {
      imports = with profiles; [
        editors.sublime-text
      ];
    };

    games = _: {
      imports = with profiles; [
        games.steam
        games.minecraft
      ];
    };

    system-preferences = _: {
      imports = with profiles; [
        system-preferences.dock
        system-preferences.finder
        system-preferences.firewall
        system-preferences.general
        system-preferences.keyboard
        system-preferences.trackpad
        system-preferences.other
      ];
    };
  }
