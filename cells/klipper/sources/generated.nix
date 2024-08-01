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
    version = "c61695ca225d593b0a5450517e474ee9e94aeb2c";
    src = fetchFromGitHub {
      owner = "DangerKlippers";
      repo = "danger-klipper";
      rev = "c61695ca225d593b0a5450517e474ee9e94aeb2c";
      fetchSubmodules = false;
      sha256 = "sha256-pcOMLmS1aLHkiZLqhddmw+WQugLliKDVylHjMgo6E5Y=";
    };
    date = "2024-07-18";
  };
  experimental-danger-klipper = {
    pname = "experimental-danger-klipper";
    version = "10002c97f87ed19dc80d05dd6dfd917c88ff535f";
    src = fetchFromGitHub {
      owner = "DangerKlippers";
      repo = "danger-klipper";
      rev = "10002c97f87ed19dc80d05dd6dfd917c88ff535f";
      fetchSubmodules = false;
      sha256 = "sha256-zXtuodlHSjnxvKnP2gypMNmNPSay3DzQSS6s7rVssqs=";
    };
    date = "2024-07-01";
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
    version = "12cd1d9e81c32b26ccc319af1dfc3633438908f1";
    src = fetchFromGitHub {
      owner = "Klipper3d";
      repo = "klipper";
      rev = "12cd1d9e81c32b26ccc319af1dfc3633438908f1";
      fetchSubmodules = false;
      sha256 = "sha256-swjZc3Lu8rOwaYQby8QQvTzuNnxtTAaZx7TY/D8Z7Qg=";
    };
    date = "2024-07-18";
  };
  klipper-cartographer = {
    pname = "klipper-cartographer";
    version = "8b5affc66abbca096fc2602619131921149e2439";
    src = fetchFromGitHub {
      owner = "Cartographer3D";
      repo = "cartographer-klipper";
      rev = "8b5affc66abbca096fc2602619131921149e2439";
      fetchSubmodules = false;
      sha256 = "sha256-Q8D2wNYY0a3yWdy43Xd+7ddjVPH3rsMbMEffksyAiOc=";
    };
    date = "2024-07-19";
  };
  klipper-chopper-resonance-tuner = {
    pname = "klipper-chopper-resonance-tuner";
    version = "9d3cb80a2dfb4a0ff1ea7d1bb7c9cf554eef7863";
    src = fetchFromGitHub {
      owner = "MRX8024";
      repo = "chopper-resonance-tuner";
      rev = "9d3cb80a2dfb4a0ff1ea7d1bb7c9cf554eef7863";
      fetchSubmodules = false;
      sha256 = "sha256-lCQDXTJ5+wwprDh/0OA0t9+FUsd8oxlCuHL6il/yKCM=";
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
    version = "38e1ab6ad7be7f2defca55db1f794e2c47b30cc7";
    src = fetchFromGitHub {
      owner = "moggieuk";
      repo = "Happy-Hare";
      rev = "38e1ab6ad7be7f2defca55db1f794e2c47b30cc7";
      fetchSubmodules = false;
      sha256 = "sha256-rM76TkAKWU9xT7+9buLXoF28pu+GDqmA05+J32CICnU=";
    };
    date = "2024-07-16";
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
    version = "4a55dab8ec21585b48251d43cb40dfa16e25f350";
    src = fetchFromGitHub {
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "4a55dab8ec21585b48251d43cb40dfa16e25f350";
      fetchSubmodules = false;
      sha256 = "sha256-qFBdSYUiv/MU7a6iJ1rC5M7fdZUwRMB7sy7ZU0txpIY=";
    };
    date = "2024-07-21";
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
    version = "477c9589e0112717918cf320dfdaeefd1c40e08d";
    src = fetchFromGitHub {
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "477c9589e0112717918cf320dfdaeefd1c40e08d";
      fetchSubmodules = false;
      sha256 = "sha256-vs4351R2zgbj4hrwyiWykPLEPdDQ3pHYFJkyMXCk3JI=";
    };
    date = "2024-07-18";
  };
  mobileraker-companion = {
    pname = "mobileraker-companion";
    version = "14f5e432506f801411b19e8654865026411a8ea5";
    src = fetchFromGitHub {
      owner = "Clon1998";
      repo = "mobileraker_companion";
      rev = "14f5e432506f801411b19e8654865026411a8ea5";
      fetchSubmodules = false;
      sha256 = "sha256-VeHzy+MnckEqxbrPs4sEN5RlIp4y6su4381u2sp/afs=";
    };
    date = "2024-07-20";
  };
  moonraker = {
    pname = "moonraker";
    version = "5c62149fc439f26e10e55783d4d8ce9e9c177c77";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "moonraker";
      rev = "5c62149fc439f26e10e55783d4d8ce9e9c177c77";
      fetchSubmodules = false;
      sha256 = "sha256-oaM46QhEbLoka8wpDdcsqLi304QBYUKlMMmFgSZ0JlE=";
    };
    date = "2024-07-22";
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
