{pkgs, ...}: {
  environment.systemPackages = [
    (
      pkgs.v4l-utils.override
      {
        withGUI = false;
      }
    )
    pkgs.camera-streamer
  ];

  users.groups.dma-heap = {};

  services.udev.extraRules = ''
    SUBSYSTEM=="dma_heap", GROUP="dma-heap", MODE="0660"
  '';

  tl.services.camera-streamer.instances = {
    nozzle = {
      settings = {
        camera = {
          path = "/dev/v4l/by-id/usb-3DO_3DO_NOZZLE_CAMERA_V2_3DO-video-index0";
          width = 1280;
          height = 720;
          fps = 60;
          format = "MJPG";
          nbufs = 2;
          force_active = true;
          options = {
            autoexposure = 3;
            backlightcompensation = 1;
            brightness = -10;
            contrast = 1;
            gamma = 100;
            sharpness = 5;
          };
        };

        http = {
          port = 8080;
          listen = "0.0.0.0";
        };

        rtsp = {
          port = 8554;
        };
      };

      nginx.enable = true;
    };

    printer = {
      settings = {
        camera = {
          path = "/dev/v4l/by-id/usb-3DO_3DO_USB_CAMERA_V2_3DO-video-index0";
          width = 1280;
          height = 720;
          fps = 30;
          format = "MJPG";
          force_active = true;
          nbufs = 2;
          # options = {
          #   whitebalanceautomatic = 0;
          #   whitebalancetemperature = 5700;
          # };
        };

        http.port = 8081;
      };

      nginx.enable = true;
    };
  };

  # boot.kernelParams = [
  #   "cma=256M"
  # ];

  boot.blacklistedKernelModules = ["snd-usb-audio"]; # Disable mic on cameras for some USB bandwidth

  hardware.raspberry-pi."4".dwc2 = {
    enable = true;
    dr_mode = "host";
  };
}
