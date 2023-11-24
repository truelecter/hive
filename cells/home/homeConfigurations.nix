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
  }: {
    imports =
      (l.attrValues homeModules)
      ++ [
        userProfiles.minimal
        common.commonProfiles.cachix
      ];

    home.username = username;
    home.homeDirectory = homedir;
    home.stateVersion = "23.05";

    nix.settings.store = "${homedir}/.nix";

    targets.genericLinux.enable = true;

    tl.home.alien = true;

    bee.system = system;
    bee.home = inputs.home;
    bee.pkgs = import inputs.nixos {
      inherit system;
      config.allowUnfree = true;
      overlays = with inputs.cells.common.overlays; [
        common-packages
        latest-overrides
      ];
    };
  };
in {
  "truelecter@gate2" = defaultUser {username = "truelecter";};
  "truelecter@fido-tazik" = defaultUser {username = "truelecter";};
  "truelecter@fido2" = defaultUser {username = "truelecter";};
}
