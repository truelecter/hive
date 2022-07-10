{
  config,
  lib,
  pkgs,
  ...
}: {
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    # Whether to display icons on the desktop.
    CreateDesktop = false;
    FXDefaultSearchScope = "SCcf";
    FXEnableExtensionChangeWarning = false;
    FXPreferredViewStyle = "Nlsv";
    QuitMenuItem = false;
    ShowPathbar = false;
    ShowStatusBar = true;
    _FXShowPosixPathInTitle = true;

    # DisableAllAnimations = true;
    # WarnOnEmptyTrash = true;
    # ShowRecentTags = false;
  };
}
