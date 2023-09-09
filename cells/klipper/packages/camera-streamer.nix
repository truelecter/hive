{
  lib,
  stdenv,
  sources,
  # tools
  pkg-config,
  ccache,
  unixtools,
  cmake,
  # dependencies
  nlohmann_json,
  ffmpeg,
  libcamera,
  live555,
  gnutls,
  # Build flags
  useHWH264 ? true,
  useFfmpeg ? false,
  useLibcamera ? false,
  useRtsp ? false,
  useLibdatachannel ? true,
  ...
}: let
  inherit (lib) optionals optional;
in
  stdenv.mkDerivation rec {
    pname = "camera-streamer";

    inherit (sources.camera-streamer) version src;

    # NIX_DEBUG = 1;
    # NIX_CFLAGS_COMPILE = "-Wno-error";

    hardeningDisable = ["all"];

    makeFlags =
      [
        "GIT_VERSION=${version}"
        "GIT_REVISION=${version}"
      ]
      ++ optional useHWH264 "USE_HW_H264=1"
      ++ optional useFfmpeg "USE_FFMPEG=1"
      ++ optional useLibcamera "USE_LIBCAMERA=1"
      ++ optional useRtsp "USE_RTSP=1";

    nativeBuiltInputs = [pkg-config ccache unixtools.xxd cmake];

    buildInputs =
      [nlohmann_json]
      ++ optional useFfmpeg ffmpeg
      ++ optional useLibcamera libcamera
      ++ optional useRtsp live555
      ++ optional useLibdatachannel gnutls;

    configurePhase = ''
      echo '#define GIT_VERSION "${version}"' > version.h
      echo '#define GIT_REVISION "${version}"' >> version.h

      sed -i 's/all: version/all:/g' Makefile
      export PATH="${pkg-config}/bin:${unixtools.xxd}/bin:${cmake}/bin::$PATH"
    '';

    installPhase = ''
      $preInstallPhase

      mkdir -p $out/bin

      cp camera-streamer $out/bin/

      $postInstallPhase
    '';

    meta = with lib; {
      description = "Touchscreen GUI that interfaces with Klipper via Moonraker";
      homepage = "https://klipperscreen.readthedocs.io/en/latest/";
      platforms = platforms.linux;
      license = licenses.gpl3Only;
    };
  }
