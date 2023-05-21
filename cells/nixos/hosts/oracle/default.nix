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
    profiles.remote-builds
    ./_hardware-configuration.nix
    ./_minecraft-servers.nix
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services.vnstat.enable = true;

  system.stateVersion = "22.11";

  # for remote builds
  # users.users.root = {
  #   openssh.authorizedKeys.keys = [
  #     (builtins.readFile ./../../../secrets/sops/ssh/root_nas.pub)
  #   ];
  # };
}
