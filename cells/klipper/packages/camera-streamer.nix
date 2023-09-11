{
  lib,
  stdenv,
  sources,
  # tools
  pkg-config,
  ccache,
  unixtools,
  # dependencies
  nlohmann_json,
  ffmpeg,
  libcamera,
  live555,
  usrsctp,
  libdatachannel,
  libjuice,
  openssl,
  srtp,
  # Build flags
  useHWH264 ? true,
  useFfmpeg ? false,
  useLibcamera ? false,
  useRtsp ? false,
  useLibdatachannel ? true,
  ...
}: let
  inherit (lib) optionals optional optionalString;

  libdatachannel0_17 = libdatachannel.overrideAttrs (_: _: {
    inherit (sources.libdatachannel0_17) version src;

    buildInputs = [
      libjuice
      openssl
      srtp
    ];

    cmakeFlags = [
      "-DUSE_SYSTEM_SRTP=ON"
      "-DUSE_SYSTEM_JUICE=ON"
      "-DNO_EXAMPLES=ON"
    ];
  });
in
  stdenv.mkDerivation rec {
    pname = "camera-streamer";

    inherit (sources.camera-streamer) version src;

    hardeningDisable = ["all"];

    makeFlags =
      [
        "-DGIT_VERSION=${version}"
        "-DGIT_REVISION=${version}"
        "-DUSE_LIBDATACHANNEL=0"
      ]
      ++ optional useHWH264 "-DUSE_HW_H264=1"
      ++ optional useFfmpeg "-DUSE_FFMPEG=1"
      ++ optional useLibcamera "-DUSE_LIBCAMERA=1"
      ++ optional useRtsp "-DUSE_RTSP=1";

    nativeBuildInputs = [pkg-config ccache unixtools.xxd];

    buildInputs =
      [nlohmann_json]
      ++ optional useFfmpeg ffmpeg
      ++ optional useLibcamera libcamera
      ++ optional useRtsp live555
      ++ optionals useLibdatachannel ([libdatachannel0_17 usrsctp] ++ libdatachannel0_17.buildInputs);

    configurePhase = ''
      echo '#define GIT_VERSION "${version}"' > version.h
      echo '#define GIT_REVISION "${version}"' >> version.h

      sed -i 's/all: version/all:/g' Makefile

      ${optionalString useLibdatachannel ''
        export NIX_CFLAGS_COMPILE="-DUSE_LIBDATACHANNEL $NIX_CFLAGS_COMPILE"
        export NIX_LDFLAGS="$NIX_LDFLAGS -ljuice -ldatachannel -lsrtp2 -lcrypto -lssl -lusrsctp"
      ''}

      rm -rf third_party/libdatachannel
    '';

    buildPhase = ''
      make camera-streamer list-devices
    '';

    installPhase = ''
      $preInstallPhase

      mkdir -p $out/bin
      cp camera-streamer list-devices $out/bin/

      $postInstallPhase
    '';

    meta = with lib; {
      description = "High-performance low-latency camera streamer for Raspberry PI's";
      homepage = "https://github.com/ayufan/camera-streamer/tree/main";
      platforms = platforms.linux;
      # license = licenses.gpl3Only;
    };
  }
