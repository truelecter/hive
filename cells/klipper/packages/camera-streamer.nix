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
  useRtsp ? false, # Broken while live555 is not compiling for whatever reason
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

  live555Custom = live555.overrideAttrs (_: _: {
    inherit (sources.live555) version src;

    # env.NIX_CFLAGS_COMPILE = "-DNO_STD_LIB";
    postPatch = ''
      sed -i -e 's|/bin/rm|rm|g' genMakefiles
      sed -i \
        -e 's/$(INCLUDES) -I. -O2 -DSOCKLEN_T/$(INCLUDES) -I. -O2 -I. -fPIC -DRTSPCLIENT_SYNCHRONOUS_INTERFACE=1 -DSOCKLEN_T/g' \
        config.linux
    '';
  });
in
  stdenv.mkDerivation rec {
    pname = "camera-streamer";

    inherit (sources.camera-streamer) version src;

    hardeningDisable = ["all"];

    NIX_DEBUG = 1;

    makeFlags =
      [
        # Targets
        "camera-streamer"
        "list-devices"
        "GIT_VERSION=${version}"
        "GIT_REVISION=${version}"
        "USE_LIBDATACHANNEL=0"
      ]
      ++ optional useHWH264 "USE_HW_H264=1"
      ++ optional useFfmpeg "USE_FFMPEG=1"
      ++ optional useLibcamera "USE_LIBCAMERA=1"
      ++ optional useRtsp "USE_RTSP=1";

    nativeBuildInputs = [pkg-config ccache unixtools.xxd];

    buildInputs =
      [nlohmann_json]
      ++ optional useFfmpeg ffmpeg
      ++ optional useLibcamera libcamera
      ++ optionals useRtsp [openssl]
      ++ optionals useLibdatachannel ([libdatachannel0_17 usrsctp] ++ libdatachannel0_17.buildInputs);

    configurePhase = ''
      echo '#define GIT_VERSION "${version}"' > version.h
      echo '#define GIT_REVISION "${version}"' >> version.h

      sed -i 's/all: version/all:/g' Makefile

      ${optionalString useLibdatachannel ''
        export NIX_CFLAGS_COMPILE="-DUSE_LIBDATACHANNEL $NIX_CFLAGS_COMPILE"
        export NIX_LDFLAGS="$NIX_LDFLAGS -ljuice -ldatachannel -lsrtp2 -lcrypto -lssl -lusrsctp"
      ''}

      ${optionalString useRtsp ''
        export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -isystem ${live555Custom}/include/liveMedia -isystem ${live555Custom}/include/groupsock -isystem ${live555Custom}/include/UsageEnvironment -isystem ${live555Custom}/include/BasicUsageEnvironment"
        export NIX_LDFLAGS="$NIX_LDFLAGS -L${live555Custom}/lib -lBasicUsageEnvironment -lliveMedia -lUsageEnvironment -lgroupsock"
      ''}

      rm -rf third_party/libdatachannel
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
