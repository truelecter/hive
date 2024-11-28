{...}: {
  imports = [
    ./z2m.nix
    ./home-assistant.nix
    ./mqtt.nix
  ];

  systemd.tmpfiles.rules = [
    "d '/srv/home-assistant' 0775 root root - -"
  ];
}
