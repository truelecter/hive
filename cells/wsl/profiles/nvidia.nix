{
  inputs,
  common,
  nixos,
}: {
  lib,
  pkgs,
  config,
  ...
}: let
  nvidia_x11 = config.boot.kernelPackages.nvidia_x11;
  nvidia_gl = nvidia_x11.out;
  nvidia_gl_32 = nvidia_x11.lib32;
in {
  boot.extraModulePackages = [nvidia_x11];
  environment.systemPackages = [nvidia_x11];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [nvidia_gl];
    extraPackages32 = [nvidia_gl_32];
  };

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    nvidiaSettings = false;
    open = true;
  };
}
