{
  config,
  pkgs,
  suites,
  profiles,
  lib,
  ...
}: {
  imports =
    suites.base
    ++ [
      profiles.networking.tailscale
    ]
    ++ [
      ./hardware-configuration.nix
      # ./octoprint.nix
      ./wifi.nix
      ./gpio.nix
      ./camera.nix
      ./klipper
    ];

  networking = {
    hostName = "octoprint";
    firewall.enable = false;
  };

  services.vnstat.enable = true;

  system.stateVersion = "22.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };
}
