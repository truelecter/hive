# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  rock-pi-x-firmware = {
    pname = "rock-pi-x-firmware";
    version = "20200828-0711";
    src = fetchurl {
      url = "https://dl.radxa.com/rockpix/drivers/firmware/AP6255_BT_WIFI_Firmware.zip";
      sha256 = "sha256-G5Q0/N02G3eO/+S1ELhOcX4+znWJz67FXsiUTvmDYAM=";
    };
  };
}
