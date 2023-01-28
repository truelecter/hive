# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  klipper = {
    pname = "klipper";
    version = "0407c24c78c65d590497020bf1003ac4f3ee5d0d";
    src = fetchFromGitHub ({
      owner = "Klipper3d";
      repo = "klipper";
      rev = "0407c24c78c65d590497020bf1003ac4f3ee5d0d";
      fetchSubmodules = false;
      sha256 = "sha256-TscZXUYIsuau2eigRUS9H5iRlKTASfplmLIJbtHvuNU=";
    });
    date = "2023-01-25";
  };
  klipper-led_effect = {
    pname = "klipper-led_effect";
    version = "5d16b1c26b9e233a388b3126b59e54ee5fea709b";
    src = fetchFromGitHub ({
      owner = "julianschill";
      repo = "klipper-led_effect";
      rev = "5d16b1c26b9e233a388b3126b59e54ee5fea709b";
      fetchSubmodules = false;
      sha256 = "sha256-l9/I2YflDtiG72gL3rMy6SW8rD4iPJJ/IKDgrSVOi08=";
    });
    date = "2022-11-15";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "b96adf55edd9389fc8f7e182a9104d790e86375a";
    src = fetchFromGitHub ({
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "b96adf55edd9389fc8f7e182a9104d790e86375a";
      fetchSubmodules = false;
      sha256 = "sha256-6LalpQhW5HmdNwrXGx4homLg0EDp0N7Y/cPNNYPkBFc=";
    });
    date = "2022-12-13";
  };
  libcamera = {
    pname = "libcamera";
    version = "9b860a664e9cd7ca4889c6f8d7f0e8d402199de3";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera";
      rev = "9b860a664e9cd7ca4889c6f8d7f0e8d402199de3";
      fetchSubmodules = false;
      sha256 = "sha256-qkSHyvV/7Ga6DJacQJs5wLYjkqF57HQtPv9JCqftruE=";
    });
    date = "2023-01-24";
  };
  libcamera-apps = {
    pname = "libcamera-apps";
    version = "9f08463997b82c4bf60e12c4ea43577959a8ae15";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera-apps";
      rev = "9f08463997b82c4bf60e12c4ea43577959a8ae15";
      fetchSubmodules = false;
      sha256 = "sha256-UBTDHN0lMj02enB8im4Q+f/MCm/G2mFPP3pLImrZc5A=";
    });
    date = "2023-01-25";
  };
  mainsail = {
    pname = "mainsail";
    version = "v2.4.1";
    src = fetchurl {
      url = "https://github.com/mainsail-crew/mainsail/releases/download/v2.4.1/mainsail.zip";
      sha256 = "sha256-+g6RIfXn06qzDYcFSjZlxwXbwyWcGvf5++KbO59pu0M=";
    };
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
    version = "12b1befcbc42ca1bb22843efa75131e3e04f43b4";
    src = fetchFromGitHub ({
      owner = "Arksine";
      repo = "moonraker";
      rev = "12b1befcbc42ca1bb22843efa75131e3e04f43b4";
      fetchSubmodules = false;
      sha256 = "sha256-GTjUI7pCvK8fb4DALv6FYIp8RFdOhe0DOikByDZbea0=";
    });
    date = "2023-01-24";
  };
  moonraker-telegram-bot = {
    pname = "moonraker-telegram-bot";
    version = "688fad426a83f893cecdf1fbc3ef710c94295974";
    src = fetchFromGitHub ({
      owner = "nlef";
      repo = "moonraker-telegram-bot";
      rev = "688fad426a83f893cecdf1fbc3ef710c94295974";
      fetchSubmodules = false;
      sha256 = "sha256-E8JvzC5b+/Dy/1mvgANhNzGx3gGodMvzgQKeeW1rPvU=";
    });
    date = "2023-01-27";
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
    version = "cc9adca9e74c52bbfbf4512188948001049c1833";
    src = fetchFromGitHub ({
      owner = "bubbleboy14";
      repo = "registeredeventlistener";
      rev = "cc9adca9e74c52bbfbf4512188948001049c1833";
      fetchSubmodules = false;
      sha256 = "sha256-fg0EZ2jDjmuQNmFXnNmmi3/Jcufg0mb0IBNi3UXgiYk=";
    });
    date = "2021-12-13";
  };
  rpi-fw = {
    pname = "rpi-fw";
    version = "52cf38d0ae55a8b7426e55974292a920265b7927";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "firmware";
      rev = "52cf38d0ae55a8b7426e55974292a920265b7927";
      fetchSubmodules = false;
      sha256 = "sha256-xIzrmo0pHEUOAXlkWW8kKplW4apGyJJ/SG7Soi9knK0=";
    });
    date = "2023-01-24";
  };
  rpi-fw-bluez = {
    pname = "rpi-fw-bluez";
    version = "9556b08ace2a1735127894642cc8ea6529c04c90";
    src = fetchFromGitHub ({
      owner = "RPi-Distro";
      repo = "bluez-firmware";
      rev = "9556b08ace2a1735127894642cc8ea6529c04c90";
      fetchSubmodules = false;
      sha256 = "sha256-gKGK0XzNrws5REkKg/JP6SZx3KsJduu53SfH3Dichkc=";
    });
    date = "2023-01-05";
  };
  rpi-fw-nonfree = {
    pname = "rpi-fw-nonfree";
    version = "7f29411baead874b859eda53efdc2472345ea454";
    src = fetchFromGitHub ({
      owner = "RPi-Distro";
      repo = "firmware-nonfree";
      rev = "7f29411baead874b859eda53efdc2472345ea454";
      fetchSubmodules = false;
      sha256 = "sha256-54JKmwypD7PRQdd7k6IcF7wL8ifMavEM0UwZwmA24O4=";
    });
    date = "2023-01-25";
  };
  rpi-linux = {
    pname = "rpi-linux";
    version = "0dea520e0ef59a311869f2209156ad6c16d753c8";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "linux";
      rev = "0dea520e0ef59a311869f2209156ad6c16d753c8";
      fetchSubmodules = false;
      sha256 = "sha256-qQRi4znyyyC+kZwCr+f0YV8htKNJMUQVCujl9mnYuPg=";
    });
    date = "2023-01-25";
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
    version = "83ce8bc6a1016bcea46da48e9090f8e761478149";
    src = fetchFromGitHub ({
      owner = "peak";
      repo = "s5cmd";
      rev = "83ce8bc6a1016bcea46da48e9090f8e761478149";
      fetchSubmodules = false;
      sha256 = "sha256-8WoIUTRd2Ooot70hsAYVz9bEKKkK9Hs279RL+8D2Qfk=";
    });
    date = "2022-09-20";
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
    version = "v1.7.1";
    src = fetchurl {
      url = "https://github.com/6c65726f79/Transmissionic/releases/download/v1.7.1/Transmissionic-webui-v1.7.1.zip";
      sha256 = "sha256-uAXoSvwVGb6+aSiJ5VKJUab0MzcQKCxYfkoDbhqWmfo=";
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
