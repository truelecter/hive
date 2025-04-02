{
  pkgs,
  lib,
  ...
}: {
  nix.linux-builder = {
    enable = true;
    maxJobs = 8;

    config = {
      virtualisation.cores = 8;
      virtualisation.darwin-builder.diskSize = 100 * 1024;
      virtualisation.darwin-builder.memorySize = 8 * 1024;
      # users.users.builder.extraGroups = ["wheel"];
    };
  };
}
