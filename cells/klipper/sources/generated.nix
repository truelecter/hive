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
  experimental-kalico = {
    pname = "experimental-kalico";
    version = "6ecd0a34986cbfdb63ed372a9314a7e2b049e384";
    src = fetchFromGitHub {
      owner = "KalicoCrew";
      repo = "kalico";
      rev = "6ecd0a34986cbfdb63ed372a9314a7e2b049e384";
      fetchSubmodules = false;
      sha256 = "sha256-m8ZNqaKWz2j4eWS2K4Hh4JAtoQzqJMivhACNwJcub8A=";
    };
    date = "2025-01-17";
  };
  kalico = {
    pname = "kalico";
    version = "2ac98c38c1eb60197480e6fc09713fef3e550374";
    src = fetchFromGitHub {
      owner = "KalicoCrew";
      repo = "kalico";
      rev = "2ac98c38c1eb60197480e6fc09713fef3e550374";
      fetchSubmodules = false;
      sha256 = "sha256-2Y7nv8WZWQMP5uO7ZsHnf0JRI1r5SR/I1KuZp/MUscg=";
    };
    date = "2025-01-17";
  };
  katapult = {
    pname = "katapult";
    version = "25a23cd420d7f0f7b677f1511b5739385fca72d9";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "katapult";
      rev = "25a23cd420d7f0f7b677f1511b5739385fca72d9";
      fetchSubmodules = false;
      sha256 = "sha256-b6FYEn56TVRvTyWhkq4Wa5AFpRZH0S8wSi0o9m/7QBQ=";
    };
    date = "2024-12-18";
  };
  klipper = {
    pname = "klipper";
    version = "cf3b0475daa0d7154d2f986f94d8c184c7cf39c1";
    src = fetchFromGitHub {
      owner = "Klipper3d";
      repo = "klipper";
      rev = "cf3b0475daa0d7154d2f986f94d8c184c7cf39c1";
      fetchSubmodules = false;
      sha256 = "sha256-ElcqMBqkuBV9XrlRvOr6rY0YUFGmLLkHJYk/3T6Jeyo=";
    };
    date = "2025-01-10";
  };
  klipper-cartographer = {
    pname = "klipper-cartographer";
    version = "157c0dacf39eb96d784918f4b2b8877e9a70413c";
    src = fetchFromGitHub {
      owner = "Cartographer3D";
      repo = "cartographer-klipper";
      rev = "157c0dacf39eb96d784918f4b2b8877e9a70413c";
      fetchSubmodules = false;
      sha256 = "sha256-RjRtyDt7eVvi69Aq7TSCuwWnFWIkle6MahjrgXhuPV4=";
    };
    date = "2025-01-09";
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
    version = "a58288e7e3a67675acaa8edd223f87f2dc93f217";
    src = fetchFromGitHub {
      owner = "dw-0";
      repo = "kiauh";
      rev = "a58288e7e3a67675acaa8edd223f87f2dc93f217";
      fetchSubmodules = false;
      sha256 = "sha256-DtvxYEYrAAfVpdaJ2mOwnC0Vf262f4mWfhngcLSaBAc=";
    };
    date = "2025-01-03";
  };
  klipper-happy-hare = {
    pname = "klipper-happy-hare";
    version = "5d34de2c28c0e050537a0ca1dbdc6156b7313c84";
    src = fetchFromGitHub {
      owner = "moggieuk";
      repo = "Happy-Hare";
      rev = "5d34de2c28c0e050537a0ca1dbdc6156b7313c84";
      fetchSubmodules = false;
      sha256 = "sha256-UJzXRDCpkC8u020tSgkuXduEWekqqCEMUep/mYd3bFc=";
    };
    date = "2025-01-11";
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
    version = "7bcaa8fecd72180a1af5084626f522edcc496d3c";
    src = fetchFromGitHub {
      owner = "Frix-x";
      repo = "klippain-shaketune";
      rev = "7bcaa8fecd72180a1af5084626f522edcc496d3c";
      fetchSubmodules = false;
      sha256 = "sha256-aALcWn7+iyb+hRVGbQHtpXQGtx9sr5e6q8kOeEPIx0M=";
    };
    date = "2025-01-06";
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
    version = "fb3c6bc12dca71cbd7a49f9388321769e3f4d490";
    src = fetchFromGitHub {
      owner = "SanaaHamel";
      repo = "nevermore-controller";
      rev = "fb3c6bc12dca71cbd7a49f9388321769e3f4d490";
      fetchSubmodules = false;
      sha256 = "sha256-CpEk9rC48ts5zYjd00D0JSIRcFtAV5gVRibiWNUTbAc=";
    };
    date = "2024-12-09";
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
    version = "7ed39038cec15c55cf05f60965aec4a2e31fa954";
    src = fetchFromGitHub {
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "7ed39038cec15c55cf05f60965aec4a2e31fa954";
      fetchSubmodules = false;
      sha256 = "sha256-vzGPjigmjxIO5hY1VXf119jIt8ouyy79Ah4uTs9GVh8=";
    };
    date = "2025-01-08";
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
    version = "9f0777e19e705e78c7f530d34992dc31fa0741ab";
    src = fetchFromGitHub {
      owner = "andrewmcgr";
      repo = "klipper_tmc_autotune";
      rev = "9f0777e19e705e78c7f530d34992dc31fa0741ab";
      fetchSubmodules = false;
      sha256 = "sha256-qfnTUxPHlTubMD8MFRKKexBJwz44XLwXHzLoOOjG0M0=";
    };
    date = "2025-01-04";
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
    version = "05e9e410a043fa5f2e2e461d34a35391f9982b84";
    src = fetchFromGitHub {
      owner = "mainsail-crew";
      repo = "mainsail";
      rev = "05e9e410a043fa5f2e2e461d34a35391f9982b84";
      fetchSubmodules = false;
      sha256 = "sha256-4BBj8q5SA+q19WqHT+2ZV2p5R+i93oEeKhVV5lKeIEA=";
    };
    date = "2025-01-03";
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
    version = "72ed175c520e3b9e3054e9ad7d27157577300df1";
    src = fetchFromGitHub {
      owner = "Arksine";
      repo = "moonraker";
      rev = "72ed175c520e3b9e3054e9ad7d27157577300df1";
      fetchSubmodules = false;
      sha256 = "sha256-g5bBDiVpL4Ak3YYEMfbfnfq1/oA4Cl68GEJujJHvmC4=";
    };
    date = "2025-01-13";
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
