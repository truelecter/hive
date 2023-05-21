{
  inputs,
  suites,
  profiles,
  ...
}: let
  system = "aarch64-linux";
in {
  imports = [
    suites.base

    profiles.common.networking.tailscale
    inputs.nixos-hardware.nixosModules.raspberry-pi-4

    ./_hardware-configuration.nix
    ./_wifi.nix
    ./_gpio.nix
    ./_camera.nix
    ./_klipper
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        deviceTree.applyOverlays = prev.callPackage ./_apply-overlays-dtmerge.nix {};
      })

      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // {allowMissing = true;});
      })
    ];
  };

  networking = {
    hostName = "octoprint";
    firewall.enable = false;
  };

  services.vnstat.enable = true;

  system.stateVersion = "22.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };
}
