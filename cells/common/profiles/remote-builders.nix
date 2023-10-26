{
  cell,
  inputs,
}: {config, ...}: {
  imports = [
    inputs.cells.secrets.commonProfiles.remote-builders
  ];

  # environment.etc."nix/builder_pk" = {
  #   source = config.sops.secrets.remote-builder-pk.path;
  # };

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
        sshKey = config.sops.secrets.remote-builder-pk.path;
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
      #   sshKey = config.sops.secrets.remote-builder-pk.path;
      # }
    ];
  };
}
