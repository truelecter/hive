# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  libcamera = {
    pname = "libcamera";
    version = "34f4e38ad5045a24b46ae7f1a69fb91c180cea2e";
    src = fetchFromGitHub {
      owner = "raspberrypi";
      repo = "libcamera";
      rev = "34f4e38ad5045a24b46ae7f1a69fb91c180cea2e";
      fetchSubmodules = false;
      sha256 = "sha256-xC9PdYnB0quERSpdTEMIvhT5TIXek/hYzHjWXRPiOvQ=";
    };
    date = "2025-01-06";
  };
  libcamera-apps = {
    pname = "libcamera-apps";
    version = "e821e4aa1b3a8d3b1f11878cb5acdeb1007616fd";
    src = fetchFromGitHub {
      owner = "raspberrypi";
      repo = "libcamera-apps";
      rev = "e821e4aa1b3a8d3b1f11878cb5acdeb1007616fd";
      fetchSubmodules = false;
      sha256 = "sha256-CvQrKYvCRJiw33ad7w+xoM/ORMoI3FVuA8igRtNz7Xs=";
    };
    date = "2025-01-09";
  };
  mediamtx = {
    pname = "mediamtx";
    version = "e424a42538c83aecc8d5fe96a318cfd1ab84632c";
    src = fetchFromGitHub {
      owner = "bluenviron";
      repo = "mediamtx";
      rev = "e424a42538c83aecc8d5fe96a318cfd1ab84632c";
      fetchSubmodules = false;
      sha256 = "sha256-LeRyjYBa2l7EuHYx8EesKvgbugH7P37bJFJpk9HAmlg=";
    };
    date = "2025-01-10";
  };
}
