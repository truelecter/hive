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
    suites.rpi
    suites.tailscale
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = with inputs.cells.common.overlays; [
      common-packages
      latest-overrides
      (
        final: prev: {
          makeModulesClosure = x: prev.makeModulesClosure (x // {allowMissing = true;});
        }
      )
    ];
  };

  tl.provision.secrets = {
    unencryptedBase = "/boot/firmware/secrets/";
    expectedSecrets = ["wifi-envs" "tailscale-key"];
  };

  system.stateVersion = "23.05";
}
