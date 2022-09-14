final: prev: {
  libcamera-rpi = prev.libcamera.overrideAttrs (o: rec {
    inherit (prev.sources.libcamera) pname version src;

    buildInputs =
      o.buildInputs
      ++ [
        final.libyaml
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
  });
}
