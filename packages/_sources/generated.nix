# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  eeprom-editor = {
    pname = "eeprom-editor";
    version = "3.2.0";
    src = fetchFromGitHub ({
      owner = "cp2004";
      repo = "OctoPrint-EEPROM-Marlin";
      rev = "3.2.0";
      fetchSubmodules = false;
      sha256 = "sha256-GNeDo6PIVQ+yHglHne/WJtfgYh8KF09GY9gzfr1Le5Q=";
    });
  };
  klipper = {
    pname = "klipper";
    version = "7290c14531211d027b430f36db5645ce496be900";
    src = fetchFromGitHub ({
      owner = "Klipper3d";
      repo = "klipper";
      rev = "7290c14531211d027b430f36db5645ce496be900";
      fetchSubmodules = false;
      sha256 = "sha256-+BSsk2G6g4IJsbG6pggYb9vcaezqNUXEAXXAcMMhAfw=";
    });
    date = "2022-10-06";
  };
  klipper-screen = {
    pname = "klipper-screen";
    version = "a83bbed85a70d9c0ec9db0c72457da4f6740498c";
    src = fetchFromGitHub ({
      owner = "jordanruthe";
      repo = "KlipperScreen";
      rev = "a83bbed85a70d9c0ec9db0c72457da4f6740498c";
      fetchSubmodules = false;
      sha256 = "sha256-boxJimH/nUEQDh6EKiC+tDVDQxVoxvmhANaanl8xhKs=";
    });
    date = "2022-10-04";
  };
  libcamera = {
    pname = "libcamera";
    version = "e68e0f1ed2880ea26b5e317f94e2bbd5332e1598";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera";
      rev = "e68e0f1ed2880ea26b5e317f94e2bbd5332e1598";
      fetchSubmodules = false;
      sha256 = "sha256-maeLpR3zNuSROlaGAYZMJ/Bp1GodWIchXNkjLgRrY6Y=";
    });
  };
  libcamera-apps = {
    pname = "libcamera-apps";
    version = "6bade0b112aca37fd9762d180203e376867ff09c";
    src = fetchFromGitHub ({
      owner = "raspberrypi";
      repo = "libcamera-apps";
      rev = "6bade0b112aca37fd9762d180203e376867ff09c";
      fetchSubmodules = false;
      sha256 = "sha256-K57+9YTZNLHi0ljabDm1r/h5nkAIvS7Gvj25e+rcpcs=";
    });
  };
  mainsail = {
    pname = "mainsail";
    version = "v2.3.1";
    src = fetchurl {
      url = "https://github.com/mainsail-crew/mainsail/releases/download/v2.3.1/mainsail.zip";
      sha256 = "sha256-WRBxWCrHhAgtarjEU8izAuUBZTxOoQxZ+MjzCQ0C3P4=";
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
    version = "60b871adbe3ed363ca999d3a080cf335a71baddb";
    src = fetchFromGitHub ({
      owner = "Arksine";
      repo = "moonraker";
      rev = "60b871adbe3ed363ca999d3a080cf335a71baddb";
      fetchSubmodules = false;
      sha256 = "sha256-sdYLgfDPPMY8q3xCEX/n5tzbuiYRmoAK+zgd5SnPBQU=";
    });
    date = "2022-09-27";
  };
  octoprint-display-layer-progress = {
    pname = "octoprint-display-layer-progress";
    version = "1.28.0";
    src = fetchFromGitHub ({
      owner = "OllisGit";
      repo = "OctoPrint-DisplayLayerProgress";
      rev = "1.28.0";
      fetchSubmodules = false;
      sha256 = "sha256-FoQGv7a3ktodyQKOwR69/9Up+wPoW5NDq+k5LfP9WYs=";
    });
  };
  rtsp-simple-server = {
    pname = "rtsp-simple-server";
    version = "85ce12199aa324a8399407aac41f8b2fbaad279d";
    src = fetchFromGitHub ({
      owner = "aler9";
      repo = "rtsp-simple-server";
      rev = "85ce12199aa324a8399407aac41f8b2fbaad279d";
      fetchSubmodules = false;
      sha256 = "sha256-egmTcEhfBxUw8fOpcft0Sna7zXxAfI264yZECDpWYQE=";
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
    version = "v1.7.0";
    src = fetchurl {
      url = "https://github.com/6c65726f79/Transmissionic/releases/download/v1.7.0/Transmissionic-webui-v1.7.0.zip";
      sha256 = "sha256-JrOref90eUQDT3IgG0NaTIHzabgTTpvEVZG22dBgY7g=";
    };
  };
}
