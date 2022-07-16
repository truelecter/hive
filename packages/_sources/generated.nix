# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  manix = {
    pname = "manix";
    version = "d08e7ca185445b929f097f8bfb1243a8ef3e10e4";
    src = fetchFromGitHub ({
      owner = "mlvzk";
      repo = "manix";
      rev = "d08e7ca185445b929f097f8bfb1243a8ef3e10e4";
      fetchSubmodules = false;
      sha256 = "sha256-GqPuYscLhkR5E2HnSFV4R48hCWvtM3C++3zlJhiK/aw=";
    });
  };
  s5cmd = {
    pname = "s5cmd";
    version = "eea87b1626220b49b98a02749475ef67328798ad";
    src = fetchFromGitHub ({
      owner = "peak";
      repo = "s5cmd";
      rev = "eea87b1626220b49b98a02749475ef67328798ad";
      fetchSubmodules = false;
      sha256 = "sha256-US7BlmoK8WhzOIASThN+DS8qUzyBMRL+E707Y2N0Qw8=";
    });
  };
  tfenv = {
    pname = "tfenv";
    version = "c05c364a0565b0bee63d97b763def4521d620884";
    src = fetchFromGitHub ({
      owner = "tfutils";
      repo = "tfenv";
      rev = "c05c364a0565b0bee63d97b763def4521d620884";
      fetchSubmodules = false;
      sha256 = "sha256-2Fpaj/UQDE7PNFX9GNr4tygvKmm/X0yWVVerJ+Y6eks=";
    });
  };
  transmissionic = {
    pname = "transmissionic";
    version = "6a08343d55b0561767cb9e91c936170c7f84bcbd";
    src = fetchFromGitHub ({
      owner = "6c65726f79";
      repo = "Transmissionic";
      rev = "6a08343d55b0561767cb9e91c936170c7f84bcbd";
      fetchSubmodules = false;
      sha256 = "sha256-wiRjLLRLP4TVCDaHwCubuH9vNTqjr7CbP9DKPUjvajI=";
    });
  };
}