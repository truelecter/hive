# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  cypress-aarch64 = {
    pname = "cypress-aarch64";
    version = "10.10.0";
    src = fetchurl {
      url = "https://cdn.cypress.io/desktop/10.10.0/linux-arm64/cypress.zip";
      sha256 = "sha256-izMbLdQj0B3/Bha9rjYlaLqdQvptJMrLBWGkz8abP8c=";
    };
  };
  klipper = {
    pname = "klipper";
    version = "83308a10510ca4efa022c463b5e6455192f8a0a7";
    src = fetchFromGitHub ({
      owner = "Klipper3d";
      repo = "klipper";
      rev = "83308a10510ca4efa022c463b5e6455192f8a0a7";
      fetchSubmodules = false;
      sha256 = "sha256-d0xLQFoWfe/cPs4Jk8Y44UTn1Y0sPtSDUUB+Lw3pobQ=";
    });
    date = "2023-04-07";
  };
  klipper-led_effect = {
    pname = "klipper-led_effect";
    version = "35cf587fe958fe15a07c11b60564856582890460";
    src = fetchFromGitHub ({
      owner = "julianschill";
      repo = "klipper-led_effect";
      rev = "35cf587fe958fe15a07c11b60564856582890460";
      fetchSubmodules = false;
      sha256 = "sha256-AZase17sO85Bp14DocUn+m6jT8P5ABXBJFdH7t4ANog=";
    });
    date = "2023-02-04";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "a1c602b46d7e7f19614be9b50767b5cf38342193";
    src = fetchFromGitHub ({
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "a1c602b46d7e7f19614be9b50767b5cf38342193";
      fetchSubmodules = false;
      sha256 = "sha256-QyWg82r/vD9j2ZWpSm7+4xtoZ8YxGMZQcfbgfWXW9d4=";
    });
    date = "2023-03-24";
  };
  libcamera = {
    pname = "libcamera";
    version = "06bbff9c23d5a85acd65595216c6b75094891f72";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera";
      rev = "06bbff9c23d5a85acd65595216c6b75094891f72";
      fetchSubmodules = false;
      sha256 = "sha256-H3Zv2CFH4BU5+vBC28wIGSkTUuWaQhqjUdv8R/bfdRc=";
    });
    date = "2023-03-13";
  };
  libcamera-apps = {
    pname = "libcamera-apps";
    version = "cd9e4e1b8f791a44cea7ee19917bd40fce1acafa";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera-apps";
      rev = "cd9e4e1b8f791a44cea7ee19917bd40fce1acafa";
      fetchSubmodules = false;
      sha256 = "sha256-xjwZ/ATyoIPtn5ubt6u3Lf72VsKHh05BBimv0Vm9W/M=";
    });
    date = "2023-03-31";
  };
  mainsail-raw = {
    pname = "mainsail-raw";
    version = "6b68be112107a24476e8f0dc66d571566065c082";
    src = fetchFromGitHub ({
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "6b68be112107a24476e8f0dc66d571566065c082";
      fetchSubmodules = false;
      sha256 = "sha256-k/5gYu0gkTrq/8CY61/2602DiFtxJg58c8b8qMVZ1EE=";
    });
    date = "2023-04-02";
  };
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
    date = "2021-04-20";
  };
  moonraker = {
    pname = "moonraker";
    version = "31e589abdeac2c45a48bb3aba1cb103f45eed5a0";
    src = fetchFromGitHub ({
      owner = "Arksine";
      repo = "moonraker";
      rev = "31e589abdeac2c45a48bb3aba1cb103f45eed5a0";
      fetchSubmodules = false;
      sha256 = "sha256-cfLq6uAAzWuf6IP5HiYdJBEoTnrk5Lnf2RcabRq/ck4=";
    });
    date = "2023-04-04";
  };
  moonraker-telegram-bot = {
    pname = "moonraker-telegram-bot";
    version = "b9b47003e13b8a23af696594aac8ba53c777f5a7";
    src = fetchFromGitHub ({
      owner = "nlef";
      repo = "moonraker-telegram-bot";
      rev = "b9b47003e13b8a23af696594aac8ba53c777f5a7";
      fetchSubmodules = false;
      sha256 = "sha256-kvr3Ywg1Mc4yJerNJochPiHBD20zcpPbB7n3HEDQzZA=";
    });
    date = "2023-02-05";
  };
  otf2bdf = {
    pname = "otf2bdf";
    version = "4fb7b6546c62e212475ecd61dee7d7255a60fc99";
    src = fetchFromGitHub ({
      owner = "jirutka";
      repo = "otf2bdf";
      rev = "4fb7b6546c62e212475ecd61dee7d7255a60fc99";
      fetchSubmodules = false;
      sha256 = "sha256-8z1uqUhUPK+fMW3PLkvF3eSlSJpo0x+6NQ6vYsEMqoM=";
    });
    date = "2021-09-18";
  };
  pam-reattach = {
    pname = "pam-reattach";
    version = "0fbdc4cebce66179cb2daee3d88944acd6cef505";
    src = fetchFromGitHub ({
      owner = "fabianishere";
      repo = "pam_reattach";
      rev = "0fbdc4cebce66179cb2daee3d88944acd6cef505";
      fetchSubmodules = false;
      sha256 = "sha256-9N944FcYM72hpTkT7jZoOoG7KfWvIhROHKXDh+dNTOQ=";
    });
    date = "2022-07-15";
  };
  python-networkmanager = {
    pname = "python-networkmanager";
    version = "2.2";
    src = fetchurl {
      url = "https://pypi.io/packages/source/p/python-networkmanager/python-networkmanager-2.2.tar.gz";
      sha256 = "sha256-3m65IdlKunVJ9CjtKzqkgqXVQ+y2lly6oPu1VasxudU=";
    };
  };
  rel = {
    pname = "rel";
    version = "26d62ef6ebaf3e84c90363b579e0885ab1d458b8";
    src = fetchFromGitHub ({
      owner = "bubbleboy14";
      repo = "registeredeventlistener";
      rev = "26d62ef6ebaf3e84c90363b579e0885ab1d458b8";
      fetchSubmodules = false;
      sha256 = "sha256-SDW3W8wCq/5ci4qOvPlclbBg9dlhKyXHz8vZ/Rb9qk0=";
    });
    date = "2023-03-16";
  };
  rtsp-simple-server = {
    pname = "rtsp-simple-server";
    version = "79562b15ab342bb34d29ffc3cae6a076ed51490a";
    src = fetchFromGitHub ({
      owner = "aler9";
      repo = "rtsp-simple-server";
      rev = "79562b15ab342bb34d29ffc3cae6a076ed51490a";
      fetchSubmodules = false;
      sha256 = "sha256-ouHkxWLcGGKKKdNTs2qSzuaUGAW73vxvq9EbgiXpzsg=";
    });
  };
  s5cmd = {
    pname = "s5cmd";
    version = "3e080613218175bb7b1f62cf45cee16eee901792";
    src = fetchFromGitHub ({
      owner = "peak";
      repo = "s5cmd";
      rev = "3e080613218175bb7b1f62cf45cee16eee901792";
      fetchSubmodules = false;
      sha256 = "sha256-jhjptEDak591vziIj6CIc4I85MM73EVi+OyBAfFOtkg=";
    });
    date = "2023-02-02";
  };
  tfenv = {
    pname = "tfenv";
    version = "1ccfddb22005b34eacaf06a9c33f58f14e816ec9";
    src = fetchFromGitHub ({
      owner = "tfutils";
      repo = "tfenv";
      rev = "1ccfddb22005b34eacaf06a9c33f58f14e816ec9";
      fetchSubmodules = false;
      sha256 = "sha256-UNvLJQB47IRcNZpoUGXTW2g63ApijnIB3oUb7Zu4lUY=";
    });
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
  wsaccel = {
    pname = "wsaccel";
    version = "0.6.4";
    src = fetchurl {
      url = "https://pypi.io/packages/source/w/wsaccel/wsaccel-0.6.4.tar.gz";
      sha256 = "sha256-y/ZqiLyvbGrRbVDqKSFYkVJrbpk8S8ftRLBE7m/jrT0=";
    };
  };
  zig = {
    pname = "zig";
    version = "d42a719e8f7ba31a9e18d6be9d58691b0b38c69a";
    src = fetchFromGitHub ({
      owner = "ziglang";
      repo = "zig";
      rev = "d42a719e8f7ba31a9e18d6be9d58691b0b38c69a";
      fetchSubmodules = false;
      sha256 = "sha256-FwXvZBpe7rSKte17TkeeQs4is2/nsYyi9oxcv/09NSY=";
    });
  };
}
