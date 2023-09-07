{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  environment.systemPackages = [
    pkgs.dtc
    pkgs.v4l-utils
    pkgs.ustreamer
    pkgs.gdb
  ];

  tl.services.tailscale-tls.enable = true;

  services.mediamtx = {
    enable = true;
    settings = {
      hlsAlwaysRemux = true;
      hlsVariant = "lowLatency";
      hlsSegmentDuration = "200ms";
      hlsPartDuration = "200ms";

      hlsEncryption = true;
      hlsServerKey = "${config.tl.services.tailscale-tls.target}/key.key";
      hlsServerCert = "${config.tl.services.tailscale-tls.target}/cert.crt";

      paths = {
        cam = {
          runOnInit = builtins.replaceStrings ["\n"] [""] "${pkgs.ffmpeg_5-full}/bin/ffmpeg -vcodec h264 -framerate 25 -video_size 640x480 -f v4l2
            -i /dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920_89E7787F-video-index0
            -c:v libx264 -preset ultrafast -pix_fmt yuv420p
            -flags low_delay -strict experimental -g 50 -crf 18
            -f rtsp rtsp://localhost:8554/cam";
          runOnInitRestart = true;
          runOnReady = "/bin/sh -c '${pkgs.v4l-utils}/bin/v4l2-ctl -c focus_auto=0; ${pkgs.v4l-utils}/bin/v4l2-ctl -c sharpness=140 -c focus_absolute=30'";
        };
        nozzle = {
          runOnInit = builtins.replaceStrings ["\n"] [""] "${pkgs.ffmpeg_5-full}/bin/ffmpeg -vcodec h264 -framerate 25 -video_size 640x480 -f v4l2
            -i /dev/v4l/by-id/usb-XCG-221208-J_3DO_NOZZLE_CAMERA_4K_01.00.00-video-index0
            -c:v libx264 -preset ultrafast -pix_fmt yuv420p
            -flags low_delay -strict experimental -g 50 -crf 18
            -f rtsp rtsp://localhost:8555/cam";
          runOnInitRestart = true;
          runOnReady = "/bin/sh -c '${pkgs.v4l-utils}/bin/v4l2-ctl -c focus_auto=0; ${pkgs.v4l-utils}/bin/v4l2-ctl -c sharpness=140 -c focus_absolute=30'";
        };
      };
    };
  };

  users.groups.dma-heap = {};

  services.udev.extraRules = ''
    SUBSYSTEM=="dma_heap", GROUP="dma-heap", MODE="0660"
  '';

  systemd.services.mediamtx = {
    after = ["tailscale-tls.service"];
    partOf = ["tailscale-tls.service"];

    serviceConfig.SupplementaryGroups = lib.mkForce "video tailscale-tls dma-heap";
  };
}
