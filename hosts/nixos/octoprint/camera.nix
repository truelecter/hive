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
    pkgs.libcamera
    pkgs.ffmpeg_5
    # pkgs.libcamera-apps
    pkgs.gdb
    # pkgs.rpi-videocore
  ];

  # environment.variables = {
  #   LIBCAMERA_IPA_PROXY_PATH = "${pkgs.libcamera-rpi}/libexec/libcamera";
  # };

  tl.services.tailscale-tls.enable = true;

  services.rtsp-simple-server = {
    enable = false;
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
          runOnInit = builtins.replaceStrings ["\n"] [""] "${pkgs.ffmpeg_5}/bin/ffmpeg -vcodec h264 -framerate 25 -video_size 1280x720 -f v4l2
            -i /dev/v4l/by-id/usb-Alpha_Imaging_Tech._Corp._Razer_Kiyo-video-index0
            -c:v libx264 -preset ultrafast -pix_fmt yuv420p
            -flags low_delay -strict experimental -g 50 -crf 18
            -f rtsp rtsp://localhost:8554/cam";
          runOnInitRestart = true;
        };
        # cam = {
        #   source = "rpiCamera";
        #   rpiCameraWidth = 1920;
        #   rpiCameraHeight = 1080;
        # };
      };
    };
    # env = {
    #   LIBCAMERA_IPA_PROXY_PATH = "${pkgs.libcamera-rpi}/libexec/libcamera";
    # };
  };

  users.groups.dma-heap = {};

  services.udev.extraRules = ''
    SUBSYSTEM=="dma_heap", GROUP="dma-heap", MODE="0660"
  '';

  # systemd.services.rtsp-simple-server = let
  #   ldconfig = pkgs.writeScriptBin "ldconfig" ''
  #     #!${pkgs.stdenv.shell}
  #     echo 'libcamera.so => ${pkgs.libcamera-rpi}/lib/libcamera.so'
  #     echo 'libcamera-base.so => ${pkgs.libcamera-rpi}/lib/libcamera-base.so'
  #   '';
  # in {
  #   after = ["tailscale-tls.service"];
  #   partOf = ["tailscale-tls.service"];

  #   serviceConfig.SupplementaryGroups = lib.mkForce "video tailscale-tls dma-heap";
  #   path = [
  #     ldconfig
  #   ];
  # };
}
