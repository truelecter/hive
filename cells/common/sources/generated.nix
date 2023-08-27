# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  s5cmd = {
    pname = "s5cmd";
    version = "10e4ccf4b9421c2063d301ebc8987064994e3c17";
    src = fetchFromGitHub {
      owner = "peak";
      repo = "s5cmd";
      rev = "10e4ccf4b9421c2063d301ebc8987064994e3c17";
      fetchSubmodules = false;
      sha256 = "sha256-h62p5kOk09KQ4ksoiFs/0JuSAn4TAGmBb/xHb/8JObM=";
    };
    date = "2023-08-23";
  };
  tfenv = {
    pname = "tfenv";
    version = "1ccfddb22005b34eacaf06a9c33f58f14e816ec9";
    src = fetchFromGitHub {
      owner = "tfutils";
      repo = "tfenv";
      rev = "1ccfddb22005b34eacaf06a9c33f58f14e816ec9";
      fetchSubmodules = false;
      sha256 = "sha256-UNvLJQB47IRcNZpoUGXTW2g63ApijnIB3oUb7Zu4lUY=";
    };
    date = "2022-10-01";
  };
  transmissionic = {
    pname = "transmissionic";
    version = "v1.8.0";
    src = fetchurl {
      url = "https://github.com/6c65726f79/Transmissionic/releases/download/v1.8.0/Transmissionic-webui-v1.8.0.zip";
      sha256 = "sha256-IhbJCv9SWjLspJYv6dBKrooGk+vA7sq1N3WzMne6PEw=";
    };
  };
}
