{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
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
          path = "/dev/v4l/by-id/usb-XCG-221208-J_3DO_NOZZLE_CAMERA_4K_01.00.00-video-index0";
          width = 640;
          height = 480;
          fps = 60;
          format = "MJPG";
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
          path = "/dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920_89E7787F-video-index0";
          width = 640;
          height = 480;
          fps = 30;
          format = "MJPG";
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
}
