{
  lib,
  stdenv,
  sources,
  fetchFromGitHub,
  srcOnly,
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
  plog,
  libjuice,
  openssl,
  srtp,
  # Build flags
  useHWH264 ? true,
  useFfmpeg ? false,
  useLibcamera ? false,
  useRtsp ? true, # Broken while live555 is not compiling for whatever reason
  useLibdatachannel ? true,
  ...
}: let
  inherit (lib) optionals optional optionalString;

  customUsrsctp = usrsctp.overrideAttrs (finalAttrs: previousAttrs: {
    version = "unstable-2021-10-08";
    src = fetchFromGitHub {
      owner = "sctplab";
      repo = "usrsctp";
      rev = "7c31bd35c79ba67084ce029511193a19ceb97447";
      hash = "sha256-KeOR/0WDtG1rjUndwTUOhE21PoS+ETs1Vk7jQYy/vNs=";
    };
  });

  libdatachannel0_17 = libdatachannel.overrideAttrs (_: _: {
    inherit (sources.libdatachannel0_17) version src;

    buildInputs = [
      libjuice
      openssl
      srtp
    ];

    postPatch = ''
      # TODO: Remove when updating to 0.19.x, and add
      # -DUSE_SYSTEM_USRSCTP=ON and -DUSE_SYSTEM_PLOG=ON to cmakeFlags instead
      mkdir -p deps/{usrsctp,plog}
      cp -r --no-preserve=mode ${srcOnly customUsrsctp}/. deps/usrsctp
      cp -r --no-preserve=mode ${srcOnly plog}/. deps/plog
    '';

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
        export NIX_LDFLAGS="$NIX_LDFLAGS -L${live555Custom}/lib -lliveMedia -lgroupsock -lBasicUsageEnvironment -lUsageEnvironment"
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
