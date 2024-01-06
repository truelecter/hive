# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  libcamera = {
    pname = "libcamera";
    version = "563cd78e1c9858769f7e4cc2628e2515836fd6e7";
    src = fetchFromGitHub {
      owner = "raspberrypi";
      repo = "libcamera";
      rev = "563cd78e1c9858769f7e4cc2628e2515836fd6e7";
      fetchSubmodules = false;
      sha256 = "sha256-T5MBTTYaDfaWEo/czTE822e5ZXQmcJ9pd+RWNoM4sBs=";
    };
    date = "2023-11-22";
  };
  libcamera-apps = {
    pname = "libcamera-apps";
    version = "122b835fb927dffa86f0c3437042d3f0048709bc";
    src = fetchFromGitHub {
      owner = "raspberrypi";
      repo = "libcamera-apps";
      rev = "122b835fb927dffa86f0c3437042d3f0048709bc";
      fetchSubmodules = false;
      sha256 = "sha256-6GNbRAmmrJXNBwVEfejmV4TA+UzJSNO7ng/xyN3qSh8=";
    };
    date = "2024-01-02";
  };
  mediamtx = {
    pname = "mediamtx";
    version = "bc7804cb33bd38650f72b382994f14e5b2d4eef1";
    src = fetchFromGitHub {
      owner = "bluenviron";
      repo = "mediamtx";
      rev = "bc7804cb33bd38650f72b382994f14e5b2d4eef1";
      fetchSubmodules = false;
      sha256 = "sha256-2bq/vKOwX+joTqQ1NVeNkAbdCbDyLIEzHGMRDFqyrFw=";
    };
    date = "2024-01-04";
  };
}
