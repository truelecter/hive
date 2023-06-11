{
  inputs,
  suites,
  ...
}: let
  system = "x86_64-linux";
in {
  imports = [
    suites.wsl
    suites.tailscale
  ];

  wsl = {
    nativeSystemd = true;
  };

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

  system.stateVersion = "22.05";
}
