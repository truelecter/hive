{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "usb_storage" "sd_mod" "sdhci_acpi"];
      kernelModules = [];
      includeDefaultModules = true;
    };

    kernelModules = ["kvm-intel"];
    kernelParams = ["quiet"];
    extraModulePackages = [];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 1;
      };

      efi.canTouchEfiVariables = true;
      timeout = lib.mkForce 5;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/system";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.opengl.enable = true;
  hardware.enableRedistributableFirmware = true;

  boot.plymouth.enable = true;

  hardware.firmware = [pkgs.rock-pi-x-firmware];
}
