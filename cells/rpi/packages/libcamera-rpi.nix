{
  libcamera,
  sources,
  gnutls,
  libyaml,
  boost,
  ...
}:
libcamera.overrideAttrs (o: rec {
  pname = "libcamera-rpi";

  inherit (sources.libcamera) version src;

  buildInputs =
    o.buildInputs
    ++ [
      libyaml
      gnutls
      boost
    ];

  mesonBuildType = "release";

  mesonFlags = [
    "-Dv4l2=true"
    "-Dqcam=disabled"
    "-Dlc-compliance=disabled" # tries unconditionally to download gtest when enabled
    "-Dipas=raspberrypi"
    "-Ddocumentation=disabled"
    "-Dandroid=disabled"
    "-Dgstreamer=disabled"
    "-Dpipelines=raspberrypi"
    "-Dtest=false"
    "-Dtracing=disabled"
    "-Dstrip=true"
  ];
})
