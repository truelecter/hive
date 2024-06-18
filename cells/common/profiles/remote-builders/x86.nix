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
          "x86_64-linux"
          "i686-linux"
        ];

        supportedFeatures = [
          "nixos-test"
          "benchmark"
          "kvm"
          "big-parallel"
        ];

        speedFactor = 20;
        maxJobs = 4;
        hostName = "depsos";

        sshUser = "root";
        sshKey = config.sops.secrets.remote-builder-pk.path;
      }
    ];
  };
}
