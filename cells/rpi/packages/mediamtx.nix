{
  stdenv,
  lib,
  sources,
  buildGoModule,
  cell,
  pkg-config,
  ...
}: let
  exe = stdenv.mkDerivation rec {
    pname = "mediamtx-exe";

    inherit (sources.mediamtx) version src;

    nativeBuildInputs = [
      pkg-config
    ];

    buildInputs = [
      cell.packages.libcamera-rpi
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
    pname = "mediamtx";

    inherit (sources.mediamtx) version src;

    vendorSha256 = "sha256-ZX8o7zakdw4IXkSOqvugk2zv5u2w0B5XhxENrTeoSKM=";

    # Tests need docker
    doCheck = false;

    # tags = [
    #   "rpicamera"
    # ];

    ldflags = [
      "-X github.com/aler9/mediamtx/internal/core.version=v${version}"
    ];

    # preBuild = ''
    #   cp ${exe}/exe internal/rpicamera/exe/
    # '';

    meta = with lib; {
      description = "Ready-to-use RTSP server and RTSP proxy that allows to read and publish video and audio streams";
      inherit (src.meta) homepage;
      license = licenses.mit;
      maintainers = with maintainers; [doronbehar];
    };
  }
