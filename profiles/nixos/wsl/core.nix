{pkgs, ...}: {
  wsl = {
    enable = true;

    startMenuLaunchers = true;
    # docker-native.enable = true;
    # docker-desktop.enable = true;
  };

  environment.systemPackages = let
    inherit (pkgs.linuxPackages) usbip;
  in [
    usbip
  ];
}
