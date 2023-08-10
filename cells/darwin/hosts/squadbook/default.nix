{
  suites,
  lib,
  inputs,
  profiles,
  userProfiles,
  ...
}: let
  system = "aarch64-darwin";
in {
  imports = [
    suites.base
    suites.editors
    suites.system-preferences
    suites.games

    profiles.security.yubikey
    profiles.three-d-print

    profiles.common.networking.tailscale

    profiles.users."andrii.panasiuk"
    profiles.users.root
  ];

  bee.system = system;
  bee.home = inputs.home;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.nixos {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      inputs.cells.common.overlays.latest-overrides
      inputs.cells.common.overlays.common-packages
    ];
  };

  networking = {
    hostName = lib.mkForce "squadbook";
    computerName = "Andrii.Panasiuk";
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
      "Office VPN"
      "Community VPN"
      "Tailscale Tunnel"
    ];
  };

  system.stateVersion = 4;

  nix = {
    distributedBuilds = true;

    buildMachines = [
      {
        systems = [
          "aarch64-linux"
        ];

        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "kvm"
          "big-parallel"
        ];

        speedFactor = 40;
        maxJobs = 4;
        hostName = "oracle";

        sshUser = "root";
        sshKey = "/etc/nix/builder_nas";
      }
      {
        systems = [
          "x86_64-linux"
          # "aarch64-linux"
          "i686-linux"
        ];

        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "kvm"
          "big-parallel"
        ];

        speedFactor = 40;
        maxJobs = 16;
        hostName = "hyperos";

        sshUser = "root";
        sshKey = "/etc/nix/builder_nas";
      }
      # {
      #   systems = [
      #     "x86_64-linux"
      #     "i686-linux"
      #   ];

      #   supportedFeatures = [
      #     "nixos-test"
      #     "benchmark"
      #     "kvm"
      #     "big-parallel"
      #   ];

      #   speedFactor = 10;
      #   maxJobs = 4;
      #   hostName = "depsos";

      #   sshUser = "root";
      #   sshKey = "/etc/nix/builder_nas";
      # }
    ];
  };
}
