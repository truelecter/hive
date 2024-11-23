{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    nvidiaSettings = false;
    open = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
}
