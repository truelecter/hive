{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.tl.home;
in {
  options.tl.home = {
    alien = lib.mkEnableOption "Configure nix.conf if on non-NixOS system";
  };

  config = lib.mkIf cfg.alien {
    programs.home-manager.enable = true;

    nix = {
      package = pkgs.nixVersions.nix;

      settings = let
        GB = 1024 * 1024 * 1024;
      in {
        # Prevents impurities in builds
        sandbox = true;

        # Give root user and wheel group special Nix privileges.
        trusted-users = ["truelecter" "@wheel"];

        keep-outputs = lib.mkDefault true;
        keep-derivations = lib.mkDefault true;
        builders-use-substitutes = true;
        experimental-features = ["flakes" "nix-command"];
        fallback = true;
        warn-dirty = false;

        # Some free space
        min-free = lib.mkDefault (5 * GB);
      };
    };
  };
}
