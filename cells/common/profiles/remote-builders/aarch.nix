{
  cell,
  inputs,
}: {config, ...}: {
  imports = [
    inputs.cells.secrets.commonProfiles.remote-builders
  ];

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
    ];
  };
}
