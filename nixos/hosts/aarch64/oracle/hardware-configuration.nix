{
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = false;
    device = "nodev";
    configurationLimit = 1;
  };
  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "xen_blkfront"];
  boot.initrd.kernelModules = ["nvme"];

  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/cloudimg-rootfs";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/UEFI";
    fsType = "vfat";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    firewall.enable = false;
  };

  networking.useDHCP = lib.mkDefault true;
}
