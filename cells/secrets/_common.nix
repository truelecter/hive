{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sops
  ];

  # Common secrets
  sops.secrets = {};
}
