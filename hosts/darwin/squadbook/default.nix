{
  config,
  pkgs,
  suites,
  profiles,
  lib,
  ...
}: {
  imports =
    suites.base
    ++ suites.editors
    ++ suites.system-preferences
    ++ [
      profiles.networking.tailscale
      profiles.users."andrii.panasiuk"
      profiles.users.root
      profiles.darwin.security.yubikey
    ];

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
        system = "x86_64-linux";

        supportedFeatures = [
          "big-parallel"
        ];

        speedFactor = 2;
        maxJobs = 5;
        hostName = "nix-docker";

        sshUser = "root";
        sshKey = "/etc/nix/docker_rsa";
      }
      {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "kvm"
          "big-parallel"
        ];

        speedFactor = 10;
        maxJobs = 6;
        hostName = "nas";

        sshUser = "root";
        sshKey = "/etc/nix/builder_nas";
      }
    ];
  };
}
