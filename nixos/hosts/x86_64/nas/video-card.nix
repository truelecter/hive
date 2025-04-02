{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      nvidiaSettings = false;
      open = true;
    };
    nvidia-container-toolkit.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];
}
