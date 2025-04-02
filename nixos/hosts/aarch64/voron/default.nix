{suites, ...}: {
  imports =
    suites.base
    ++ suites._3d-printing
    ++ suites.raspberry
    ++ [
      ./hardware-configuration.nix
      ./camera.nix
      ./klipper
      ./network.nix
    ];

  networking .firewall.enable = false;

  system.stateVersion = "23.05";

  users.users.truelecter = {
    extraGroups = ["video" "gpio"];
  };

  nix.settings = {
    keep-outputs = false;
    keep-derivations = false;
    system-features = [];
  };
}
