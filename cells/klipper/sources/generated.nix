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
    version = "077987b2d6a479f3e47b6f0610c013b452dcfd90";
    src = fetchFromGitHub {
      owner = "DangerKlippers";
      repo = "danger-klipper";
      rev = "077987b2d6a479f3e47b6f0610c013b452dcfd90";
      fetchSubmodules = false;
      sha256 = "sha256-2oe7Z2Zyi+aEp1KTU5/P10YuWiLd5iiUEWEKlYcj6gw=";
    };
    date = "2024-12-05";
  };
  experimental-danger-klipper = {
    pname = "experimental-danger-klipper";
    version = "0f4b3c9749919a2c4e8410bf372547115a73ccd1";
    src = fetchFromGitHub {
      owner = "DangerKlippers";
      repo = "danger-klipper";
      rev = "0f4b3c9749919a2c4e8410bf372547115a73ccd1";
      fetchSubmodules = false;
      sha256 = "sha256-bqlhbnzc1VLZCJz7evg7x84YsojkqJ7BDsugcMnRl0k=";
    };
    date = "2024-11-22";
  };
  katapult = {
    pname = "katapult";
    version = "081918ad769d1f1104ca253a4a8ace02147c345d";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "katapult";
      rev = "081918ad769d1f1104ca253a4a8ace02147c345d";
      fetchSubmodules = false;
      sha256 = "sha256-4V34JZsTCJol4PVmliH+pGyjAKnI2a3GmjXoXnSSD10=";
    };
    date = "2024-10-24";
  };
  klipper = {
    pname = "klipper";
    version = "b7233d1197d9a2158676ad39d02b80f787054e20";
    src = fetchFromGitHub {
      owner = "Klipper3d";
      repo = "klipper";
      rev = "b7233d1197d9a2158676ad39d02b80f787054e20";
      fetchSubmodules = false;
      sha256 = "sha256-zcYcuFMNfV6axXwyoIQ4fV1o7O3lUacuhNDb3/TmFBQ=";
    };
    date = "2024-12-06";
  };
  klipper-cartographer = {
    pname = "klipper-cartographer";
    version = "8324877a6dbe9bc9b4f4c2f2f5541349c55712fe";
    src = fetchFromGitHub {
      owner = "Cartographer3D";
      repo = "cartographer-klipper";
      rev = "8324877a6dbe9bc9b4f4c2f2f5541349c55712fe";
      fetchSubmodules = false;
      sha256 = "sha256-MmtaoKB21JPgBH85k7sKoPXc7qnKdMEaUTL3bi7TsSs=";
    };
    date = "2024-11-23";
  };
  klipper-chopper-resonance-tuner = {
    pname = "klipper-chopper-resonance-tuner";
    version = "1f98212ca9dbfdf15d516115dd4c26e97b914a8d";
    src = fetchFromGitHub {
      owner = "MRX8024";
      repo = "chopper-resonance-tuner";
      rev = "1f98212ca9dbfdf15d516115dd4c26e97b914a8d";
      fetchSubmodules = false;
      sha256 = "sha256-KLWWjHgEmQ9yJD6uUgjYieY8S1Td1qB5SaWN1znAGDk=";
    };
    date = "2024-08-23";
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
    version = "d9626adc983480ced54e248371a47de8834c1cd5";
    src = fetchFromGitHub {
      owner = "dw-0";
      repo = "kiauh";
      rev = "d9626adc983480ced54e248371a47de8834c1cd5";
      fetchSubmodules = false;
      sha256 = "sha256-uM36kWD+u9w55lDdneHUgewEmeIONFNdVNPYLrfzmn8=";
    };
    date = "2024-11-28";
  };
  klipper-happy-hare = {
    pname = "klipper-happy-hare";
    version = "4361abf1343ea615f8333beacb1c2459f57201bf";
    src = fetchFromGitHub {
      owner = "moggieuk";
      repo = "Happy-Hare";
      rev = "4361abf1343ea615f8333beacb1c2459f57201bf";
      fetchSubmodules = false;
      sha256 = "sha256-jdVAr9zDku+IWrqv3+7Mdwc0sF6SnBIG1yAmniFoe8k=";
    };
    date = "2024-11-27";
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
    version = "56d1d48296f8242496d47d4b4c84c558a7bab2a5";
    src = fetchFromGitHub {
      owner = "julianschill";
      repo = "klipper-led_effect";
      rev = "56d1d48296f8242496d47d4b4c84c558a7bab2a5";
      fetchSubmodules = false;
      sha256 = "sha256-dN1DgdEMxct4LVAKCfbsfXwt3B9A9EqRtziuXznVHXU=";
    };
    date = "2024-10-01";
  };
  klipper-nevermore-controller = {
    pname = "klipper-nevermore-controller";
    version = "4c69464a0a83d4afba1fc8a28567378ab0b75ed2";
    src = fetchFromGitHub {
      owner = "SanaaHamel";
      repo = "nevermore-controller";
      rev = "4c69464a0a83d4afba1fc8a28567378ab0b75ed2";
      fetchSubmodules = false;
      sha256 = "sha256-HLsSKfmaXcAV4iJKN+cNAaunG6DnlZpdpewOSx0Pwzg=";
    };
    date = "2024-10-04";
  };
  klipper-nevermore-max = {
    pname = "klipper-nevermore-max";
    version = "159df10e4f6015680107d1cbd10a3aab23dd5f18";
    src = fetchFromGitHub {
      owner = "nevermore3d";
      repo = "Nevermore_Max";
      rev = "159df10e4f6015680107d1cbd10a3aab23dd5f18";
      fetchSubmodules = false;
      sha256 = "sha256-uPTUlI2F697pDPw5HxU48dEUpBkgovb61ksXW1HRfLY=";
    };
    date = "2023-11-18";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "5df1fd9de3029cddd5f77f3de677a8f5dee19cf3";
    src = fetchFromGitHub {
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "5df1fd9de3029cddd5f77f3de677a8f5dee19cf3";
      fetchSubmodules = false;
      sha256 = "sha256-r1pOlnaG+xgV0SpoGbhBUnvoklDxmu8SEEbJ7LmOUsc=";
    };
    date = "2024-12-06";
  };
  klipper-z-calibration = {
    pname = "klipper-z-calibration";
    version = "v1.1.2";
    src = fetchFromGitHub {
      owner = "protoloft";
      repo = "klipper_z_calibration";
      rev = "v1.1.2";
      fetchSubmodules = false;
      sha256 = "sha256-YNy3FmDa4kksweWrhnwa6WKQR3sDoBxtnGh9BoXEIGs=";
    };
  };
  klipper_tmc_autotune = {
    pname = "klipper_tmc_autotune";
    version = "1aedb0802eca2655ab5bcf9966acf77ce38e8317";
    src = fetchFromGitHub {
      owner = "andrewmcgr";
      repo = "klipper_tmc_autotune";
      rev = "1aedb0802eca2655ab5bcf9966acf77ce38e8317";
      fetchSubmodules = false;
      sha256 = "sha256-s1P8yqGeZnjLZ2N2gi8PlaUXMPtXHRdWjZ5XOqNGUxY=";
    };
    date = "2024-10-28";
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
    version = "4a68186e437dd0cf954e0101047cb495e6426e22";
    src = fetchFromGitHub {
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "4a68186e437dd0cf954e0101047cb495e6426e22";
      fetchSubmodules = false;
      sha256 = "sha256-ygkzc3JBqG6GZ8GvvxorcmuY1BWyl3vJuazNdvjl5EQ=";
    };
    date = "2024-12-04";
  };
  mobileraker-companion = {
    pname = "mobileraker-companion";
    version = "1d1e2ebe101af12f83ea770301549e15055b36ea";
    src = fetchFromGitHub {
      owner = "Clon1998";
      repo = "mobileraker_companion";
      rev = "1d1e2ebe101af12f83ea770301549e15055b36ea";
      fetchSubmodules = false;
      sha256 = "sha256-1Pj9jHK/aWnDMOYo5QoIJXhuFVwW5EuZZI9V9DhaNRQ=";
    };
    date = "2024-12-04";
  };
  moonraker = {
    pname = "moonraker";
    version = "ccfe32f2368a5ff6c2497478319909daeeeb8edf";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "moonraker";
      rev = "ccfe32f2368a5ff6c2497478319909daeeeb8edf";
      fetchSubmodules = false;
      sha256 = "sha256-aCYE3EmflMRIHnGnkZ/0+zScVA5liHSbavScQ7XRf/4=";
    };
    date = "2024-11-17";
  };
  python-networkmanager = {
    pname = "python-networkmanager";
    version = "2.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/p/python-networkmanager/python-networkmanager-2.2.tar.gz";
      sha256 = "sha256-3m65IdlKunVJ9CjtKzqkgqXVQ+y2lly6oPu1VasxudU=";
    };
  };
  python-scheduler = {
    pname = "python-scheduler";
    version = "0.8.7";
    src = fetchurl {
      url = "https://pypi.org/packages/source/s/scheduler/scheduler-0.8.7.tar.gz";
      sha256 = "sha256-q1TWR0ZJZQxdBAsMwK4xTGNrEQ/Q3YMlSgSBvJNBXuU=";
    };
  };
  python-sqlalchemy-cockroachdb = {
    pname = "python-sqlalchemy-cockroachdb";
    version = "2.0.2";
    src = fetchurl {
      url = "https://pypi.org/packages/source/s/sqlalchemy-cockroachdb/sqlalchemy-cockroachdb-2.0.2.tar.gz";
      sha256 = "sha256-EZdW65BYVdahE0W5nP6FMDGj/lmKnEvzWo3ayfif6Mw=";
    };
  };
  spoolman = {
    pname = "spoolman";
    version = "v0.21.0";
    src = fetchurl {
      url = "https://github.com/Donkie/Spoolman/releases/download/v0.21.0/spoolman.zip";
      sha256 = "sha256-rGK5tmijg0t7Fmo6l5GcAK1ZGImXfb1x68dWOTTSeVU=";
    };
  };
}
