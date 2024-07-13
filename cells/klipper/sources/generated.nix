# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  camera-streamer = {
    pname = "camera-streamer";
    version = "v0.2.8";
    src = fetchFromGitHub {
      owner = "ayufan";
      repo = "camera-streamer";
      rev = "v0.2.8";
      fetchSubmodules = true;
      sha256 = "sha256-8vV8BMFoDeh22I1/qxk6zttJROaD/lrThBxXHZSPpT4=";
    };
  };
  danger-klipper = {
    pname = "danger-klipper";
    version = "24265bd814259f82d446e3f8c53fda11abf75b81";
    src = fetchFromGitHub {
      owner = "DangerKlippers";
      repo = "danger-klipper";
      rev = "24265bd814259f82d446e3f8c53fda11abf75b81";
      fetchSubmodules = false;
      sha256 = "sha256-8L3KHvcCUz54NXNA72Ltlwxqy3EMEoCWnvVvZCBzZPM=";
    };
    date = "2024-07-08";
  };
  katapult = {
    pname = "katapult";
    version = "3e23332eb188244e88f5ff60aecf077cd32bcd0c";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "katapult";
      rev = "3e23332eb188244e88f5ff60aecf077cd32bcd0c";
      fetchSubmodules = false;
      sha256 = "sha256-xFelN6fzcsdt60Ifo/qxbkj691rUfvnZzmg3nrYCAYI=";
    };
    date = "2024-02-10";
  };
  klipper = {
    pname = "klipper";
    version = "0087f04cc370cd542069940f0ed10c583de158ee";
    src = fetchFromGitHub {
      owner = "Klipper3d";
      repo = "klipper";
      rev = "0087f04cc370cd542069940f0ed10c583de158ee";
      fetchSubmodules = false;
      sha256 = "sha256-hhMkeBdS13ybhtOvmPaCM+o05zTfNcgvmoerTQ329Lc=";
    };
    date = "2024-07-11";
  };
  klipper-ercf = {
    pname = "klipper-ercf";
    version = "fb9a6c7daaf881ab507368386e733a800b26f595";
    src = fetchFromGitHub {
      owner = "EtteGit";
      repo = "EnragedRabbitProject";
      rev = "fb9a6c7daaf881ab507368386e733a800b26f595";
      fetchSubmodules = false;
      sha256 = "sha256-Gwi0HiCIlTBQkHlFnmG0sZWB2xA1y5maJxF7VdfQMxU=";
    };
    date = "2022-09-02";
  };
  klipper-gcode_shell_command = {
    pname = "klipper-gcode_shell_command";
    version = "a929c6983dd9e911d029270c63db0ac301a2fd59";
    src = fetchFromGitHub {
      owner = "dw-0";
      repo = "kiauh";
      rev = "a929c6983dd9e911d029270c63db0ac301a2fd59";
      fetchSubmodules = false;
      sha256 = "sha256-BWIlvmM6V3MFCpYYqKBAPiTlV+6v6A0UpNQClYn1Tbs=";
    };
    date = "2024-06-28";
  };
  klipper-happy-hare = {
    pname = "klipper-happy-hare";
    version = "2c48eccacf19dc1cf337ece79502a8e7893e2f52";
    src = fetchFromGitHub {
      owner = "moggieuk";
      repo = "Happy-Hare";
      rev = "2c48eccacf19dc1cf337ece79502a8e7893e2f52";
      fetchSubmodules = false;
      sha256 = "sha256-9mF77pYMk4/qsv9OK1fTRMwU1H+AtRBxum+Guk7x9zI=";
    };
    date = "2024-07-12";
  };
  klipper-kamp = {
    pname = "klipper-kamp";
    version = "v1.1.2";
    src = fetchFromGitHub {
      owner = "kyleisah";
      repo = "Klipper-Adaptive-Meshing-Purging";
      rev = "v1.1.2";
      fetchSubmodules = false;
      sha256 = "sha256-anBGjLtYlyrxeNVy1TEMcAGTVUFrGClLuoJZuo3xlDM=";
    };
  };
  klipper-klicky-probe = {
    pname = "klipper-klicky-probe";
    version = "64ad93af5e18f34216caf500e428a3f6df0a7a4d";
    src = fetchFromGitHub {
      owner = "truelecter";
      repo = "Klicky-Probe";
      rev = "64ad93af5e18f34216caf500e428a3f6df0a7a4d";
      fetchSubmodules = false;
      sha256 = "sha256-BbHkgJ8OlSF89BlSkWcpUEy8A6vPwAj6N4rvOQ7V2EQ=";
    };
    date = "2024-03-25";
  };
  klipper-klippain-shaketune = {
    pname = "klipper-klippain-shaketune";
    version = "66f5e32e4c8930afab278fcd898b47c227cc464c";
    src = fetchFromGitHub {
      owner = "Frix-x";
      repo = "klippain-shaketune";
      rev = "66f5e32e4c8930afab278fcd898b47c227cc464c";
      fetchSubmodules = false;
      sha256 = "sha256-qFW1BUeysVisDK2iP75vuTJa0nh8JatvZPp74HKPr74=";
    };
    date = "2024-07-01";
  };
  klipper-led_effect = {
    pname = "klipper-led_effect";
    version = "03a46eab5670c2934b38093993834f822a56c0fe";
    src = fetchFromGitHub {
      owner = "julianschill";
      repo = "klipper-led_effect";
      rev = "03a46eab5670c2934b38093993834f822a56c0fe";
      fetchSubmodules = false;
      sha256 = "sha256-eq6nTRQebWn+HvLh0wX6zCTx2Wcwal7RG71SDdj9isY=";
    };
    date = "2024-07-01";
  };
  klipper-nevermore-controller = {
    pname = "klipper-nevermore-controller";
    version = "14e308ff315029c2be0de498676fd23bae25ed98";
    src = fetchFromGitHub {
      owner = "SanaaHamel";
      repo = "nevermore-controller";
      rev = "14e308ff315029c2be0de498676fd23bae25ed98";
      fetchSubmodules = false;
      sha256 = "sha256-m9tSDKoU+w0+OESc2STiwa8vg9aKfxEvxnpqZjRDO5I=";
    };
    date = "2024-05-27";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "f9392e674f80b7c868448e7419e404486fcf208a";
    src = fetchFromGitHub {
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "f9392e674f80b7c868448e7419e404486fcf208a";
      fetchSubmodules = false;
      sha256 = "sha256-ELpdOBt4UZ+fJ5MJi01EUVvP3l7+MO5BC0tA7+/Mr1M=";
    };
    date = "2024-07-07";
  };
  klipper-z-calibration = {
    pname = "klipper-z-calibration";
    version = "v1.1.0";
    src = fetchFromGitHub {
      owner = "protoloft";
      repo = "klipper_z_calibration";
      rev = "v1.1.0";
      fetchSubmodules = false;
      sha256 = "sha256-8hXtWWpwNKQPxElcZYkJuCXYyRoiBBZc/Yj7LpT1O3w=";
    };
  };
  klipper_tmc_autotune = {
    pname = "klipper_tmc_autotune";
    version = "6224b7791b537c69ac6dd21e9363ebdb6c1348de";
    src = fetchFromGitHub {
      owner = "andrewmcgr";
      repo = "klipper_tmc_autotune";
      rev = "6224b7791b537c69ac6dd21e9363ebdb6c1348de";
      fetchSubmodules = false;
      sha256 = "sha256-9IheggyvEUO7N05RF/OuElwQzvzrvc2P9ETfeuNmA9k=";
    };
    date = "2024-05-22";
  };
  libdatachannel0_17 = {
    pname = "libdatachannel0_17";
    version = "v0.17.10";
    src = fetchFromGitHub {
      owner = "paullouisageneau";
      repo = "libdatachannel";
      rev = "v0.17.10";
      fetchSubmodules = false;
      sha256 = "sha256-3f84GxAgQiObe+DYuTQABvK+RTihKKFKaf48lscUex4=";
    };
  };
  libjuice = {
    pname = "libjuice";
    version = "v1.0.4";
    src = fetchFromGitHub {
      owner = "paullouisageneau";
      repo = "libjuice";
      rev = "v1.0.4";
      fetchSubmodules = false;
      sha256 = "sha256-LAqi5F6okhGj0LyJasPKRkUz6InlM6rbYN+1sX1N4Qo=";
    };
  };
  live555 = {
    pname = "live555";
    version = "2020.03.06";
    src = fetchTarball {
      url = "https://download.videolan.org/pub/contrib/live555/live.2020.03.06.tar.gz";
      sha256 = "sha256-UxunbrJC6UVlwexso/cuH9m+mUSf7WEPMLincUrqDWE=";
    };
  };
  mainsail = {
    pname = "mainsail";
    version = "55ea60e4e3c2ed6e81e6098e17e46499678e9b48";
    src = fetchFromGitHub {
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "55ea60e4e3c2ed6e81e6098e17e46499678e9b48";
      fetchSubmodules = false;
      sha256 = "sha256-JIWaIbI2a5BTVooaDiwzxxf7AO7bna01nLztl37W9y0=";
    };
    date = "2024-07-07";
  };
  mobileraker-companion = {
    pname = "mobileraker-companion";
    version = "042a5b9cccf846397f97d3f372f3e1a2b0aaf23d";
    src = fetchFromGitHub {
      owner = "Clon1998";
      repo = "mobileraker_companion";
      rev = "042a5b9cccf846397f97d3f372f3e1a2b0aaf23d";
      fetchSubmodules = false;
      sha256 = "sha256-XgmzcVJUoUcstFz2zJxVR3gXRYHS+e7v0Q8WYKv0bwQ=";
    };
    date = "2024-07-04";
  };
  moonraker = {
    pname = "moonraker";
    version = "8f3b30a04f0ffd5902075f15c52bc276e54ff690";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "moonraker";
      rev = "8f3b30a04f0ffd5902075f15c52bc276e54ff690";
      fetchSubmodules = false;
      sha256 = "sha256-sv0zjQ1znSZxdFCbXVl+pv1bh4sbXoVbDlZ6LfiKe/U=";
    };
    date = "2024-06-23";
  };
  python-networkmanager = {
    pname = "python-networkmanager";
    version = "2.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/python-networkmanager/python-networkmanager-2.2.tar.gz";
      sha256 = "sha256-3m65IdlKunVJ9CjtKzqkgqXVQ+y2lly6oPu1VasxudU=";
    };
  };
}
