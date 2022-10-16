{
  config,
  pkgs,
  ...
}: {
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.nvidiaSettings = false;
  virtualisation.docker.enableNvidia = true;
}
