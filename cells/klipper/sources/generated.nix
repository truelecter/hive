# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  klipper = {
    pname = "klipper";
    version = "00b78c68ccf42af6c75ad6051e68d494446bac94";
    src = fetchFromGitHub {
      owner = "Klipper3d";
      repo = "klipper";
      rev = "00b78c68ccf42af6c75ad6051e68d494446bac94";
      fetchSubmodules = false;
      sha256 = "sha256-OFrzF5mjUX90plYKjlPzhCeVSGbLVkgujnuaKXMwnCA=";
    };
    date = "2023-08-11";
  };
  klipper-led_effect = {
    pname = "klipper-led_effect";
    version = "35cf587fe958fe15a07c11b60564856582890460";
    src = fetchFromGitHub {
      owner = "julianschill";
      repo = "klipper-led_effect";
      rev = "35cf587fe958fe15a07c11b60564856582890460";
      fetchSubmodules = false;
      sha256 = "sha256-AZase17sO85Bp14DocUn+m6jT8P5ABXBJFdH7t4ANog=";
    };
    date = "2023-02-04";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "0a3dfbeb10565973f4a4235ff08867763c3dab24";
    src = fetchFromGitHub {
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "0a3dfbeb10565973f4a4235ff08867763c3dab24";
      fetchSubmodules = false;
      sha256 = "sha256-u50RLDi9aL6ITa7g1CKHEm2TZf3bzBTxeW4TbiRpaKg=";
    };
    date = "2023-08-03";
  };
  mainsail = {
    pname = "mainsail";
    version = "90d76c1ffeea42bc59f6d7dcc9374eee600f2cc7";
    src = fetchFromGitHub {
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "90d76c1ffeea42bc59f6d7dcc9374eee600f2cc7";
      fetchSubmodules = false;
      sha256 = "sha256-CxUuHcHwa9ivDUO1AHr6LXZXof+eXEEMsozIRMBUd+g=";
    };
    date = "2023-08-10";
  };
  moonraker = {
    pname = "moonraker";
    version = "fe120952ee06607d039af8f461028e9f5b817395";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "moonraker";
      rev = "fe120952ee06607d039af8f461028e9f5b817395";
      fetchSubmodules = false;
      sha256 = "sha256-TyhpMHu06YoaV5tZGBcYulUrABW6OFYZLyCoZLRmaUU=";
    };
    date = "2023-08-03";
  };
  moonraker-telegram-bot = {
    pname = "moonraker-telegram-bot";
    version = "ca30751a6924ffe28e26d8d708033607ad7f8e92";
    src = fetchFromGitHub {
      owner = "nlef";
      repo = "moonraker-telegram-bot";
      rev = "ca30751a6924ffe28e26d8d708033607ad7f8e92";
      fetchSubmodules = false;
      sha256 = "sha256-a4PyQaxicSHEPwM4wgh3Z57gh1zrsHXeIUwf7lWFDXY=";
    };
    date = "2023-06-15";
  };
  python-networkmanager = {
    pname = "python-networkmanager";
    version = "2.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/python-networkmanager/python-networkmanager-2.2.tar.gz";
      sha256 = "sha256-3m65IdlKunVJ9CjtKzqkgqXVQ+y2lly6oPu1VasxudU=";
    };
  };
  rel = {
    pname = "rel";
    version = "ed891f2963dfe8e15133365e4c362756a0a5f282";
    src = fetchFromGitHub {
      owner = "bubbleboy14";
      repo = "registeredeventlistener";
      rev = "ed891f2963dfe8e15133365e4c362756a0a5f282";
      fetchSubmodules = false;
      sha256 = "sha256-PrhVG1NbgpYwgzFFMNI2azQjoGKOkEJdf4MrbG0tTpg=";
    };
    date = "2023-05-23";
  };
  wsaccel = {
    pname = "wsaccel";
    version = "0.6.4";
    src = fetchurl {
      url = "https://pypi.org/packages/source/w/wsaccel/wsaccel-0.6.4.tar.gz";
      sha256 = "sha256-y/ZqiLyvbGrRbVDqKSFYkVJrbpk8S8ftRLBE7m/jrT0=";
    };
  };
}
