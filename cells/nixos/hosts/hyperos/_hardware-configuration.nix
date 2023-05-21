{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  boot.loader = {
    systemd-boot = {
      enable = false;
      consoleMode = "auto";
      editor = false;
      configurationLimit = 1;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    }; # efi
    grub = {
      devices = ["nodev"];
      enable = true;
      efiSupport = true;
      version = 2;
      useOSProber = false;
    }; # grub
  }; # bootloader

  boot.initrd.availableKernelModules = ["sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/30e9de22-7c17-4aed-8aa5-1fa715c535c0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9EDF-27B3";
    fsType = "vfat";
  };

  networking = {
    useDHCP = false;
    hostName = "hyperos";
    networkmanager.enable = true;
    firewall.enable = false;
    nameservers = ["1.1.1.1" "8.8.8.8"];
    interfaces.eth0 = {
      ipv4 = {
        addresses = [
          {
            address = "172.16.10.100";
            prefixLength = 24;
          }
        ];
        routes = [
          {
            address = "0.0.0.0";
            prefixLength = 0;
            via = "172.16.10.254";
          }
        ];
      };
    };
  };

  swapDevices = [];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  virtualisation.hypervGuest.enable = true;
}
