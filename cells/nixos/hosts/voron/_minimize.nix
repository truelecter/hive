# https://discourse.nixos.org/t/how-to-have-a-minimal-nixos/22652/4
{
  modulesPath,
  pkgs,
  ...
}: {
  disabledModules = [
    "${modulesPath}/profiles/all-hardware.nix"
    "${modulesPath}/profiles/base.nix"
  ];

  environment.systemPackages = [
    pkgs.pciutils
    pkgs.usbutils
  ];

  # environment.noXlibs = true;
  documentation.enable = false;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = false;
  documentation.nixos.enable = false;

  programs.command-not-found.enable = false;

  boot.initrd.includeDefaultModules = false;
  environment.defaultPackages = [pkgs.perl];
}
