{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs home;
  inherit (inputs.cells) common;

  l = nixpkgs.lib // builtins;
  userProfiles = cell.userProfiles;
  homeModules = cell.homeModules;

  system = nixpkgs.system;

  pkgs-with-overlays = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = with common.overlays; [
      common-packages
      latest-overrides
    ];
  };

  defaultUser = {
    system ? "x86_64-linux",
    username,
    homedir ? "/home/${username}",
  }:
    home.lib.homeManagerConfiguration {
      pkgs = pkgs-with-overlays;
      modules =
        (l.attrValues homeModules)
        ++ [
          userProfiles.minimal
          {
            home.username = username;
            home.homeDirectory = homedir;

            targets.genericLinux.enable = true;

            tl.home.alien = true;
          }
          common.commonProfiles.cachix
        ];
    };
in {
  "truelecter@gate2" = defaultUser {username = "truelecter";};
  "truelecter@fido-tazik" = defaultUser {username = "truelecter";};
}
