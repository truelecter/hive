{
  pkgs,
  inputs,
  lib,
  ...
}: let
  linuxSystem = "aarch64-linux";

  darwin-builder = inputs.latest.lib.nixosSystem {
    system = linuxSystem;
    modules = [
      "${inputs.latest}/nixos/modules/profiles/macos-builder.nix"
      {
        virtualisation = {
          host.pkgs = pkgs;
          darwin-builder = {
            diskSize = lib.mkForce (40 * 1024);
            memorySize = lib.mkForce (4 * 1024);
          };
        };

        system.nixos.revision = lib.mkForce null;
      }
    ];
  };
in {
  nix.buildMachines = [
    {
      sshUser = "builder";
      hostName = "linux-builder";
      sshKey = "/etc/nix/builder_ed25519";
      system = linuxSystem;
      maxJobs = 8;
      supportedFeatures = ["kvm" "benchmark" "big-parallel"];
      speedFactor = 200;
    }
  ];

  environment.etc."ssh/ssh_config.d/100-linux-builder.conf".text = ''
    Host linux-builder
      Hostname localhost
      HostKeyAlias linux-builder
      Port 31022
  '';

  launchd.daemons.darwin-builder = {
    command = "${darwin-builder.config.system.build.macos-builder-installer}/bin/create-builder";

    serviceConfig = {
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
      WorkingDirectory = "/etc/nix/";
    };

    environment.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };
}
