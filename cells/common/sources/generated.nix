# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  s5cmd = {
    pname = "s5cmd";
    version = "c13b860c763a56fc8b97dbb2e35e7c6f3b950f2c";
    src = fetchFromGitHub {
      owner = "peak";
      repo = "s5cmd";
      rev = "c13b860c763a56fc8b97dbb2e35e7c6f3b950f2c";
      fetchSubmodules = false;
      sha256 = "sha256-WulvXhAfZsLECFLNhAKswPYL1vDQEAOzQ6UP+3DI6Cw=";
    };
    date = "2024-06-10";
  };
  tfenv = {
    pname = "tfenv";
    version = "39d8c27ad9862ffdec57989b66fd2720cb72e76c";
    src = fetchFromGitHub {
      owner = "tfutils";
      repo = "tfenv";
      rev = "39d8c27ad9862ffdec57989b66fd2720cb72e76c";
      fetchSubmodules = false;
      sha256 = "sha256-h5ZHT4u7oAdwuWpUrL35G8bIAMasx6E81h15lTJSHhQ=";
    };
    date = "2023-12-19";
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
