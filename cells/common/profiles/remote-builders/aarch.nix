{
  cell,
  inputs,
}: {config, ...}: {
  imports = [
    inputs.cells.secrets.commonProfiles.remote-builders
  ];

  environment.etc."ssh/ssh_config.d/100-linux-builder.conf".text = ''
    Host mm4-builder
      User root
      Hostname tl-mm4
      HostKeyAlias mm4-builder
      Port 3022
      IdentityFile ${config.sops.secrets.remote-builder-pk.path}
  '';

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
        sshKey = config.sops.secrets.remote-builder-pk.path;
      }

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

        speedFactor = 100;
        maxJobs = 10;
        hostName = "mm4-builder";

        sshUser = "root";
        sshKey = config.sops.secrets.remote-builder-pk.path;
      }
    ];
  };
}
