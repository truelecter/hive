{
  pkgs,
  stdenv,
  lib,
  sources,
  buildGoModule,
  libcamera-rpi,
  pkg-config,
  ...
}: let
  exe = stdenv.mkDerivation rec {
    pname = "rtsp-simple-server-exe";

    inherit (sources.rtsp-simple-server) version src;

    nativeBuildInputs = [
      pkg-config
    ];

    buildInputs = [
      libcamera-rpi
    ];

    sourceRoot = "source/internal/rpicamera/exe";

    NIX_CFLAGS_COMPILE = [
      "-Wno-error=unused-result"
    ];

    installPhase = ''
      mkdir -p $out
      cp exe $out/
    '';
  };
in
  buildGoModule rec {
    pname = "rtsp-simple-server";

    inherit (sources.rtsp-simple-server) version src;

    vendorSha256 = "sha256-LbYBTj5pUEka2tvDypsoG5uGyyd4df3xfPM2FhSNysw=";

    # Tests need docker
    doCheck = false;

    tags = [
      "rpicamera"
    ];

    ldflags = [
      "-X github.com/aler9/rtsp-simple-server/internal/core.version=v${version}"
    ];

    preBuild = ''
      cp ${exe}/exe internal/rpicamera/exe/
    '';

    meta = with lib; {
      description = "Ready-to-use RTSP server and RTSP proxy that allows to read and publish video and audio streams";
      inherit (src.meta) homepage;
      license = licenses.mit;
      maintainers = with maintainers; [doronbehar];
    };
  }
